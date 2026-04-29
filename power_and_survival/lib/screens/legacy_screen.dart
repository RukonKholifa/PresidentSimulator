import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';
import '../data/endings_data.dart';

class LegacyScreen extends StatelessWidget {
  const LegacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    final endingId = state?.currentLegacyEnding ?? 'forgotten';
    final ending = EndingsData.getEndingById(endingId);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Legacy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.auto_stories, size: 48, color: AppTheme.accent),
                  const SizedBox(height: 12),
                  Text(ending?['title'] ?? 'Unknown Legacy', style: AppTheme.headerStyle(size: 22)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (ending != null)
              Text(ending['text'] ?? '', style: AppTheme.bodyStyle(size: 13), textAlign: TextAlign.left)
            else
              Text('Your presidency fades from memory.', style: AppTheme.bodyStyle(size: 13)),
            const SizedBox(height: 30),
            if (state != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: AppTheme.cardDecoration,
                child: Column(
                  children: [
                    Text('Final Stats', style: AppTheme.headerStyle(size: 14)),
                    const SizedBox(height: 8),
                    _statRow('Months in Power', '${state.currentMonth}'),
                    _statRow('Final Approval', '${state.stats.approvalRating.toStringAsFixed(1)}%'),
                    _statRow('Treasury', '\$${state.stats.treasury.toStringAsFixed(0)}M'),
                    _statRow('Policies Enacted', '${state.activePolicyIds.length}'),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenu, (_) => false),
                child: const Text('Main Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
          Text(value, style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w600)),
        ],
      ),
    );
  }
}
