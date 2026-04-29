import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';

class TravelCardScreen extends StatelessWidget {
  const TravelCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final destinations = [
      ('United Nations', 'Diplomatic summit with world leaders', {'internationalRelations': 5.0, 'approvalRating': 2.0}),
      ('Neighboring Capital', 'Strengthen trade relations', {'internationalRelations': 3.0, 'economy': 2.0}),
      ('Military Ally', 'Sign defense cooperation agreement', {'military': 3.0, 'internationalRelations': 2.0}),
      ('IMF Headquarters', 'Negotiate debt restructuring', {'debt': -50.0, 'economy': 1.0}),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Travel Abroad')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: destinations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final d = destinations[i];
          return Material(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                for (final e in d.$3.entries) {
                  state.stats.applyStat(e.key, e.value);
                }
                state.stats.clamp();
                state.stats.treasury -= 15;
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flight, size: 24, color: AppTheme.accent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.$1, style: AppTheme.headerStyle(size: 14)),
                          Text(d.$2, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            children: d.$3.entries.map((e) {
                              final positive = e.value > 0;
                              return Text(
                                '${e.key} ${positive ? "+" : ""}${e.value.toStringAsFixed(0)}',
                                style: AppTheme.bodyStyle(size: 9, color: positive ? AppTheme.success : AppTheme.danger),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Text('Cost: \$15M', style: AppTheme.bodyStyle(size: 10, color: AppTheme.warning)),
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
