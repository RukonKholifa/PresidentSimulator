import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../utils/random_utils.dart';

class TravelCardScreen extends StatefulWidget {
  const TravelCardScreen({super.key});

  @override
  State<TravelCardScreen> createState() => _TravelCardScreenState();
}

class _TravelCardScreenState extends State<TravelCardScreen> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.officialVisit)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose your visit:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _visitOption('Visit a Rural Province', 'Meet farmers and local leaders to boost rural support.', () {
              state.stats.happiness += 3;
              state.stats.approvalRating += 2;
              state.citizenGroups.farmers += 5;
              state.stats.treasury -= 20;
              setState(() => _result = 'You visited a rural province. Farmers appreciated your presence. +3 Happiness, +2 Approval');
              state.diaryEntries.add('Month ${state.currentMonth}: Official visit to rural province');
            }),
            _visitOption('Visit Military Base', 'Inspect troops and show support for the armed forces.', () {
              state.stats.military += 3;
              state.citizenGroups.military += 5;
              state.stats.treasury -= 15;
              setState(() => _result = 'You inspected military bases. Troops morale improved. +3 Military');
              state.diaryEntries.add('Month ${state.currentMonth}: Official visit to military base');
            }),
            _visitOption('Visit Neighbor Country', 'Diplomatic visit to improve international relations.', () {
              state.stats.internationalRelations += 5;
              state.stats.mediaTrust += 2;
              state.stats.treasury -= 30;
              final neighbor = state.neighbors.isNotEmpty ? state.neighbors[RandomUtils.nextInt(state.neighbors.length)] : null;
              if (neighbor != null) neighbor.relationScore = (neighbor.relationScore + 5).clamp(0, 100);
              setState(() => _result = 'Diplomatic visit successful. International relations improved. +5 Relations');
              state.diaryEntries.add('Month ${state.currentMonth}: Diplomatic visit abroad');
            }),
            if (_result != null) ...[
              const SizedBox(height: 24),
              Card(
                color: AppTheme.success.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.success),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_result!, style: const TextStyle(color: AppTheme.success))),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _visitOption(String title, String description, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: _result == null ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryLight),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
