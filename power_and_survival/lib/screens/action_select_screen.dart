import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';

class ActionSelectScreen extends StatelessWidget {
  const ActionSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final actions = [
      ('Press Meeting', Icons.mic, AppRoutes.pressMeeting, 'Address the media and spin your narrative'),
      ('Cabinet Meeting', Icons.groups, AppRoutes.cabinetMeeting, 'Meet with your ministers and advisors'),
      ('Parliament Vote', Icons.how_to_vote, AppRoutes.parliamentVote, 'Push legislation through parliament'),
      ('Travel Abroad', Icons.flight, AppRoutes.travelCard, 'Diplomatic visit to a neighbor'),
      ('Power Circle', Icons.people, AppRoutes.powerCircle, 'Manage your inner circle'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Action')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final a = actions[i];
          return Material(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.pushNamed(context, a.$3, arguments: state),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.cardBorder),
                ),
                child: Row(
                  children: [
                    Icon(a.$2, size: 28, color: AppTheme.accent),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.$1, style: AppTheme.headerStyle(size: 16)),
                          Text(a.$4, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textSecondary),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
