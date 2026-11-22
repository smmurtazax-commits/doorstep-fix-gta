import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  Future<void> _openWhatsApp(BuildContext context) async {
    final uri = Uri.parse(whatsAppLink);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('WhatsApp: $whatsAppDisplayNumber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Contact & Info', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('WhatsApp / Phone'),
            subtitle: const Text(whatsAppDisplayNumber),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _openWhatsApp(context),
            onLongPress: () async {
              await Clipboard.setData(const ClipboardData(text: whatsAppDisplayNumber));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Number copied')),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('How Booking Works'),
            subtitle: Text(
              'Fill the booking form in this app and tap Send on WhatsApp. '
              'Your full booking summary opens in WhatsApp to $whatsAppDisplayNumber — '
              'just press send there, and we confirm your slot by reply.',
            ),
          ),
        ),
        const SizedBox(height: 20),
        _heading(context, 'Service area — we come to you'),
        const Text(
          'No storefront. We repair at your home in:',
          style: TextStyle(height: 1.4),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: serviceCities.map((c) => Chip(label: Text(c))).toList(),
        ),
        const SizedBox(height: 20),
        _heading(context, 'Hours'),
        const Text(
          '6 days a week. Three slots a day only, so every job gets proper time:\n'
          '11:00 AM • 1:00 PM • 3:00 PM',
          style: TextStyle(height: 1.5),
        ),
        const SizedBox(height: 20),
        _heading(context, 'Deposit rule'),
        const Text(
          'If a part is not in stock, you e-transfer the part cost first. '
          'We order it, and fix your phone the day it arrives. No deposit = no order. '
          'This protects you from wrong parts and protects us from no-shows.',
          style: TextStyle(height: 1.5),
        ),
        const SizedBox(height: 20),
        _heading(context, 'Warranty'),
        const Text(
          '90-day warranty on part + labour on every repair.\n'
          'Does not cover: a new crack, a new drop, or water damage after the repair. '
          'Please back up your phone before any repair where possible.',
          style: TextStyle(height: 1.5),
        ),
        const SizedBox(height: 20),
        _heading(context, 'About'),
        const Text(
          '$trustLine. Samsung GSPN experience, warranty-claim and in-store repair background — '
          'the same professional repair, at your dining table instead of a shop counter.',
          style: TextStyle(height: 1.5),
        ),
      ],
    );
  }

  Widget _heading(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
