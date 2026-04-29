import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';
import '../widgets/advisor_comment_widget.dart';

class CabinetMeetingScreen extends StatelessWidget {
  const CabinetMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final activeChars = state.characters.where((c) => c.isActive).take(5).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Cabinet Meeting')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Advisor Briefings', style: AppTheme.headerStyle(size: 18)),
            const SizedBox(height: 12),
            ...activeChars.map((c) {
              String advice;
              if (c.loyalty > 70) {
                advice = 'Everything is under control, Mr. President. We stand with you.';
              } else if (c.loyalty < 40) {
                advice = 'The people are not happy. Perhaps we need to reconsider our approach.';
              } else {
                advice = 'The situation is manageable, but we should remain vigilant.';
              }
              return AdvisorCommentWidget(
                advisorName: '${c.name} (${c.role.replaceAll("_", " ")})',
                comment: advice,
                icon: Icons.person,
                accentColor: AppTheme.getStatColor(c.loyalty),
              );
            }),
            const SizedBox(height: 16),
            Text('Meeting Actions', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            _meetingAction(context, state, 'Rally Cabinet Unity', {'stability': 2.0}),
            _meetingAction(context, state, 'Demand Loyalty Pledge', {'stability': -1.0}),
            _meetingAction(context, state, 'Discuss Budget Priorities', {'economy': 1.0}),
          ],
        ),
      ),
    );
  }

  Widget _meetingAction(BuildContext context, GameState state, String label, Map<String, double> effects) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            for (final e in effects.entries) {
              state.stats.applyStat(e.key, e.value);
            }
            state.stats.clamp();
            Navigator.pop(context);
          },
          child: Text(label),
        ),
      ),
    );
  }
}
