import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';

class WorldMapScreen extends StatelessWidget {
  const WorldMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final neighbors = state.neighbors;

    return Scaffold(
      appBar: AppBar(title: const Text('World Map')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.cardDecoration,
              child: Column(
                children: [
                  const Icon(Icons.flag, size: 32, color: AppTheme.accent),
                  const SizedBox(height: 6),
                  Text(state.countryName, style: AppTheme.headerStyle(size: 18)),
                  Text('International Relations: ${state.stats.internationalRelations.toStringAsFixed(0)}',
                    style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text('Neighboring Countries', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            if (neighbors.isEmpty)
              Text('No diplomatic contacts established.', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary))
            else
              ...neighbors.map((n) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: AppTheme.cardDecoration,
                child: Row(
                  children: [
                    const Icon(Icons.public, size: 20, color: AppTheme.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n.name, style: AppTheme.headerStyle(size: 14)),
                          Text('${n.governmentType} | Military: ${n.militaryStrength}',
                            style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text('${n.relationScore.toStringAsFixed(0)}', style: AppTheme.headerStyle(size: 16).copyWith(color: AppTheme.getStatColor(n.relationScore))),
                        Text('relation', style: AppTheme.bodyStyle(size: 9, color: AppTheme.textSecondary)),
                      ],
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }
}
