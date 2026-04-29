import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';

class PressMeetingScreen extends StatelessWidget {
  const PressMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final topics = [
      ('Defend Economic Policy', 'Reassure citizens about the economy', {'approvalRating': 2.0, 'mediaTrust': 3.0, 'oppositionPower': -1.0}),
      ('Attack Opposition', 'Discredit your political opponents', {'oppositionPower': -3.0, 'mediaTrust': -1.0, 'stability': 1.0}),
      ('Promise Reform', 'Announce upcoming changes', {'approvalRating': 3.0, 'happiness': 1.0, 'mediaTrust': 1.0}),
      ('Deny Corruption', 'Deflect scandal allegations', {'corruption': -1.0, 'mediaTrust': -2.0, 'approvalRating': -1.0}),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Press Meeting')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final t = topics[i];
          return Material(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                for (final e in t.$3.entries) {
                  state.stats.applyStat(e.key, e.value);
                }
                state.stats.clamp();
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.$1, style: AppTheme.headerStyle(size: 14)),
                    const SizedBox(height: 4),
                    Text(t.$2, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
