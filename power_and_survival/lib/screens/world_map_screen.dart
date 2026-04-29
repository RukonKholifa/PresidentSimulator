import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../widgets/stat_bar_widget.dart';

class WorldMapScreen extends StatelessWidget {
  const WorldMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.worldMap)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.countryName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                  Text('International Relations: ${state.stats.internationalRelations.toStringAsFixed(0)}', style: const TextStyle(color: AppTheme.textSecondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(StringsEn.neighborCountries, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...state.neighbors.map((neighbor) => Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flag, color: AppTheme.accent),
                      const SizedBox(width: 8),
                      Text(neighbor.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Government: ${neighbor.governmentType}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  Text('Military: ${neighbor.militaryStrength} | Economy: ${neighbor.economicStrength}', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  StatBarWidget(label: StringsEn.relations, value: neighbor.relationScore),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
