import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';
import '../widgets/character_portrait_widget.dart';

class PowerCircleScreen extends StatefulWidget {
  const PowerCircleScreen({super.key});

  @override
  State<PowerCircleScreen> createState() => _PowerCircleScreenState();
}

class _PowerCircleScreenState extends State<PowerCircleScreen> {
  late GameState state;
  bool _initialized = false;
  bool _showDangerOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      state = ModalRoute.of(context)?.settings.arguments as GameState? ?? GameState.empty();
      _initialized = true;
    }
  }

  bool _isDangerous(character) =>
      character.loyalty < 35 ||
      character.ambition > 70 ||
      character.monthsDisloyal > 2 ||
      character.currentDemands.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final characters = state.characters.where((c) => c.isActive).toList();
    final filtered = _showDangerOnly ? characters.where(_isDangerous).toList() : characters;

    return Scaffold(
      appBar: AppBar(title: const Text('Power Circle')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppTheme.cardBackground,
            child: Row(
              children: [
                Text('${characters.length} advisors', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
                const Spacer(),
                Text('Danger Only', style: AppTheme.bodyStyle(size: 12)),
                Switch(
                  value: _showDangerOnly,
                  onChanged: (v) => setState(() => _showDangerOnly = v),
                  activeColor: AppTheme.danger,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final character = filtered[i];
                return CharacterPortraitWidget(
                  character: character,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.characterDetail,
                    arguments: {'state': state, 'character': character},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
