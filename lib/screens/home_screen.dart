import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onBookTap, required this.onPricesTap});

  final VoidCallback onBookTap;
  final VoidCallback onPricesTap;

  Future<void> _openWhatsApp(BuildContext context) async {
    final text = Uri.encodeComponent(
      'Hi DoorStep Fix GTA, I need a phone repair at my home. My phone model is: ',
    );
    final uri = Uri.parse('$whatsAppLink?text=$text');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp: $whatsAppDisplayNumber')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 8),
        Icon(Icons.phone_android, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: 12),
        Text(
          businessName,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          businessTagline,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Card(
          color: theme.colorScheme.primaryContainer,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.verified, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '$trustLine\n\n90-day warranty on part + labour.',
                    style: TextStyle(fontSize: 15, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: onBookTap,
          icon: const Icon(Icons.calendar_month),
          label: const Text('Book Appointment'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
        ),
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          onPressed: () => _openWhatsApp(context),
          icon: const Icon(Icons.chat),
          label: const Text('WhatsApp $whatsAppDisplayNumber'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
        ),
        const SizedBox(height: 24),
        Text('Popular repairs', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        const _PopularRow(title: 'iPhone Screen', price: 'from \$149'),
        const _PopularRow(title: 'iPhone Battery', price: 'from \$95'),
        const _PopularRow(title: 'Samsung Screen', price: 'from \$229'),
        const _PopularRow(title: 'Samsung Battery', price: '\$109 flat'),
        const _PopularRow(title: 'Charging Port Clean', price: '\$49'),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onPricesTap,
          icon: const Icon(Icons.price_check),
          label: const Text('See full price list'),
        ),
        const SizedBox(height: 12),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'How it works: Book a slot (11 AM, 1 PM or 3 PM) → we come to your home → '
              'fixed in front of you in 30-45 mins → pay after the fix. '
              'No shop wait, no leaving your phone anywhere.',
              style: TextStyle(height: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}

class _PopularRow extends StatelessWidget {
  const _PopularRow({required this.title, required this.price});
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.build_circle_outlined),
      title: Text(title),
      trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
