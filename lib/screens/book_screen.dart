import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../data.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _model = TextEditingController();
  final _notes = TextEditingController();

  String? _city;
  RepairService? _service;
  DateTime? _date;
  String? _slot;
  String? _summary;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _model.dispose();
    _notes.dispose();
    super.dispose();
  }

  int get _visitFee {
    if (_service == null) return homeVisitFee;
    return _service!.price >= visitFeeWaivedAt ? 0 : homeVisitFee;
  }

  int get _estimate => (_service?.price ?? 0) + _visitFee;

  String get _dateText {
    if (_date == null) return 'Pick a date';
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    return '${days[_date!.weekday - 1]} ${months[_date!.month - 1]} ${_date!.day}, ${_date!.year}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  String _buildSummary() {
    return 'Hi DoorStep Fix GTA — I want to book a home repair.\n'
        'Name: ${_name.text.trim()}\n'
        'Phone: ${_phone.text.trim()}\n'
        'City: $_city\n'
        'Phone model: ${_model.text.trim()}\n'
        'Repair: ${_service!.name} (\$${_service!.price})\n'
        'Date: $_dateText\n'
        'Slot: $_slot\n'
        'Estimate: \$$_estimate CAD '
        '(${_visitFee == 0 ? 'home visit fee waived' : 'includes \$$homeVisitFee home visit fee'})\n'
        '${_notes.text.trim().isEmpty ? '' : 'Notes: ${_notes.text.trim()}\n'}'
        'Please confirm my slot. Thank you!';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_city == null || _service == null || _date == null || _slot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick city, repair, date and time slot.')),
      );
      return;
    }
    setState(() => _summary = _buildSummary());
  }

  Future<void> _sendWhatsApp() async {
    if (_summary == null) return;
    final uri = Uri.parse('$whatsAppLink?text=${Uri.encodeComponent(_summary!)}');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open WhatsApp. Please copy the booking instead.')),
        );
      }
    }
  }

  Future<void> _copy() async {
    if (_summary == null) return;
    await Clipboard.setData(ClipboardData(text: _summary!));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied — paste it into WhatsApp: $whatsAppDisplayNumber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Book a home repair', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          const Text(
            'Fill this in, then tap Send on WhatsApp — your booking goes straight to us. '
            'No payment is taken in this app — you pay after the fix. '
            'Booking is confirmed by our WhatsApp reply.',
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Your name', border: OutlineInputBorder()),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Your phone number', border: OutlineInputBorder()),
            validator: (v) => (v == null || v.trim().length < 7) ? 'Enter a valid phone number' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _city,
            decoration: const InputDecoration(labelText: 'City / area', border: OutlineInputBorder()),
            items: serviceCities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _city = v),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _model,
            decoration: const InputDecoration(
              labelText: 'Phone model (e.g. iPhone 13, Galaxy S23)',
              border: OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<RepairService>(
            initialValue: _service,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Repair needed', border: OutlineInputBorder()),
            items: allServices
                .map((s) => DropdownMenuItem(value: s, child: Text(s.label, overflow: TextOverflow.ellipsis)))
                .toList(),
            onChanged: (v) => setState(() {
              _service = v;
              _summary = null;
            }),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today),
            label: Text(_dateText),
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
          const SizedBox(height: 12),
          const Text('Time slot', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: bookingSlots
                .map(
                  (slot) => ChoiceChip(
                    label: Text(slot),
                    selected: _slot == slot,
                    onSelected: (_) => setState(() => _slot = slot),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _notes,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Notes (address area, problem details — optional)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _service == null
                    ? 'Live estimate: pick a repair to see your total.'
                    : 'Live estimate: \$${_service!.price} repair + '
                        '${_visitFee == 0 ? '\$0 visit fee (waived \$120+)' : '\$$homeVisitFee visit fee'} '
                        '= \$$_estimate CAD',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Create Booking Summary'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          ),
          if (_summary != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(_summary!),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _sendWhatsApp,
              icon: const Icon(Icons.chat),
              label: const Text('Send on WhatsApp'),
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _copy,
              icon: const Icon(Icons.copy),
              label: const Text('Copy Booking'),
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'Samsung screens and any part not in stock: deposit for the part by e-transfer first, '
            'then we order it and fix it the day it arrives. No deposit = no order.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
