import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../widgets/character_portrait_widget.dart';

class PowerCircleScreen extends StatelessWidget {
  const PowerCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final active = state.characters.where((c) => c.isActive).toList();

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.powerCircle)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: active.length,
        itemBuilder: (context, index) {
          final char = active[index];
          return CharacterPortraitWidget(
            character: char,
            onTap: () => Navigator.pushNamed(context, AppRoutes.characterDetail, arguments: {'state': state, 'character': char}),
          );
        },
      ),
    );
  }
}
