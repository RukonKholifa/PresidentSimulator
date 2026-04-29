import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/character.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../data/characters_data.dart';
import '../widgets/stat_bar_widget.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final state = args?['state'] as GameState?;
    final character = args?['character'] as Character?;

    if (character == null) return const Scaffold(body: Center(child: Text('Error')));

    final roleName = CharactersData.roleDisplayNames[character.role] ?? character.role;

    return Scaffold(
      appBar: AppBar(title: Text(StringsEn.characterDetails)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.primaryLight,
                child: Text(character.name[0], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text(character.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            Center(child: Text(roleName, style: const TextStyle(fontSize: 14, color: AppTheme.gold))),
            const SizedBox(height: 24),
            StatBarWidget(label: StringsEn.loyalty, value: character.loyalty),
            StatBarWidget(label: StringsEn.influence, value: character.influence),
            StatBarWidget(label: StringsEn.ambition, value: character.ambition, invertColor: true),
            StatBarWidget(label: 'Corruption', value: character.corruption, invertColor: true),
            StatBarWidget(label: StringsEn.relationship, value: character.relationship),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Faction: ${character.factionId}', style: const TextStyle(fontSize: 13)),
                    if (character.currentDemands.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text('Current Demands:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...character.currentDemands.map((d) => Text('• $d', style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                    ],
                  ],
                ),
              ),
            ),
            if (state != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    character.loyalty = (character.loyalty + 10).clamp(0, 100);
                    character.relationship = (character.relationship + 5).clamp(0, 100);
                    state.stats.treasury -= 20;
                    state.diaryEntries.add('Month ${state.currentMonth}: Private meeting with ${character.name}');
                    Navigator.pop(context);
                  },
                  child: const Text('Private Meeting (+Loyalty, -\$20M)'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    character.isActive = false;
                    state.diaryEntries.add('Month ${state.currentMonth}: Dismissed ${character.name}');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
                  child: const Text(StringsEn.dismissAdvisor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
