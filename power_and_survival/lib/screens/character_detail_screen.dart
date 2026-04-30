import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';
import '../models/character.dart';
import '../widgets/stat_bar_widget.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late GameState state;
  late Character character;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      state = args?['state'] as GameState? ?? GameState.empty();
      character = args?['character'] as Character? ?? (state.characters.isNotEmpty ? state.characters.first : Character(id: 'unknown', name: 'Unknown', role: 'unknown'));
      _initialized = true;
    }
  }

  String get _moodText {
    if (character.loyalty > 70) return 'Loyal';
    if (character.loyalty > 45) return 'Uncertain';
    return 'Hostile';
  }

  Color get _moodColor {
    if (character.loyalty > 70) return AppTheme.success;
    if (character.loyalty > 45) return AppTheme.warning;
    return AppTheme.danger;
  }

  void _doAction(String action) {
    setState(() {
      switch (action) {
        case 'promote':
          character.loyalty = (character.loyalty + 10).clamp(0, 100);
          character.influence = (character.influence + 5).clamp(0, 100);
          state.stats.treasury -= 20;
        case 'meet':
          character.loyalty = (character.loyalty + 5).clamp(0, 100);
          character.relationship = (character.relationship + 5).clamp(0, 100);
        case 'fire':
          character.isActive = false;
          state.stats.stability -= 3;
        case 'arrest':
          character.isActive = false;
          state.stats.stability -= 5;
          state.stats.mediaTrust -= 5;
          if (character.corruption > 50) state.stats.corruption -= 3;
        case 'ignore':
          character.monthsDisloyal++;
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final betrayalRisk = character.loyalty < 35 && character.ambition > 60;

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.cardDecoration,
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _moodColor, width: 3),
                      color: AppTheme.background,
                    ),
                    child: const Icon(Icons.person, size: 30, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(character.name, style: AppTheme.headerStyle(size: 18)),
                  Text(character.role.replaceAll('_', ' '), style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _moodColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_moodText, style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w600, color: _moodColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: AppTheme.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stats', style: AppTheme.headerStyle(size: 14)),
                  const SizedBox(height: 8),
                  StatBarWidget(label: 'Loyalty', value: character.loyalty),
                  StatBarWidget(label: 'Influence', value: character.influence),
                  StatBarWidget(label: 'Ambition', value: character.ambition),
                  StatBarWidget(label: 'Corruption', value: character.corruption),
                  StatBarWidget(label: 'Relationship', value: character.relationship),
                ],
              ),
            ),
            if (betrayalRisk) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.danger.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.danger.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, size: 16, color: AppTheme.danger),
                    const SizedBox(width: 8),
                    Expanded(child: Text('High betrayal risk — low loyalty, high ambition',
                      style: AppTheme.bodyStyle(size: 11, color: AppTheme.danger))),
                  ],
                ),
              ),
            ],
            if (character.currentDemands.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('Active Demands', style: AppTheme.headerStyle(size: 14)),
              const SizedBox(height: 6),
              ...character.currentDemands.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(children: [
                  const Icon(Icons.priority_high, size: 14, color: AppTheme.warning),
                  const SizedBox(width: 6),
                  Text(d, style: AppTheme.bodyStyle(size: 12)),
                ]),
              )),
            ],
            const SizedBox(height: 14),
            Text('Disloyal months: ${character.monthsDisloyal}',
              style: AppTheme.bodyStyle(size: 11, color: character.monthsDisloyal > 2 ? AppTheme.danger : AppTheme.textSecondary)),
            const SizedBox(height: 20),
            Text('Actions', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 10),
            _actionRow('Promote', Icons.arrow_upward, AppTheme.success, 'promote'),
            _actionRow('Meet Privately', Icons.handshake, AppTheme.accent, 'meet'),
            _actionRow('Ignore', Icons.not_interested, AppTheme.textSecondary, 'ignore'),
            _actionRow('Fire', Icons.remove_circle, AppTheme.warning, 'fire'),
            _actionRow('Arrest', Icons.gavel, AppTheme.danger, 'arrest'),
          ],
        ),
      ),
    );
  }

  Widget _actionRow(String label, IconData icon, Color color, String action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _doAction(action),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 10),
                Text(label, style: AppTheme.bodyStyle(size: 13, color: color)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
