import 'package:flutter/material.dart';

import '../config.dart';
import '../data.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Fixed prices — no haggling, no surprises',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        const Text(
          'All prices CAD, include premium part + labour and 90-day warranty. '
          'Home visit fee \$25 — waived on repairs \$120 or more. '
          'Diagnostic \$40 — free if you do the repair with us.',
        ),
        const SizedBox(height: 20),
        _section(context, 'iPhone', iphoneServices),
        const SizedBox(height: 20),
        _section(context, 'Samsung Galaxy S', samsungServices),
        const SizedBox(height: 16),
        const Card(
          color: Color(0xFFFFF3E0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Samsung screens are deposit-first: the part is ordered for your exact model '
              'after your deposit, then we book you the day it arrives.\n\n'
              'Z Flip / Z Fold screens are NOT offered at home — too fragile and high-risk. '
              'We will happily point you to the right place for those.',
              style: TextStyle(height: 1.4),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Home visit fee: \$$homeVisitFee, waived on repairs \$$visitFeeWaivedAt+'),
      ],
    );
  }

  Widget _section(BuildContext context, String title, List<RepairService> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...services.map(
          (s) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(s.name),
              subtitle: Text(
                s.note == null ? '${s.durationMins} mins at your home' : '${s.durationMins} mins • ${s.note}',
              ),
              trailing: Text(
                '\$${s.price}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
