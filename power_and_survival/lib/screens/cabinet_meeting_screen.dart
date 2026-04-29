import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/character_manager.dart';
import '../widgets/advisor_comment_widget.dart';

class CabinetMeetingScreen extends StatelessWidget {
  const CabinetMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final charManager = CharacterManager();
    final activeChars = state.characters.where((c) => c.isActive).toList();

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.cabinetMeetingTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Your advisors share their perspectives:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...activeChars.map((char) => AdvisorCommentWidget(
            advisor: char,
            comment: charManager.getAdvisorComment(char),
          )),
          const SizedBox(height: 24),
          const Text('Loyalty Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.gold)),
          const SizedBox(height: 8),
          ...activeChars.map((char) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                SizedBox(width: 120, child: Text(charManager.getRoleDisplayName(char.role), style: const TextStyle(fontSize: 12))),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: char.loyalty / 100,
                      backgroundColor: AppTheme.primaryMid,
                      valueColor: AlwaysStoppedAnimation(AppTheme.getStatColor(char.loyalty)),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${char.loyalty.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: AppTheme.getStatColor(char.loyalty))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
