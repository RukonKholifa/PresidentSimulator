import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';

class PressMeetingScreen extends StatefulWidget {
  const PressMeetingScreen({super.key});

  @override
  State<PressMeetingScreen> createState() => _PressMeetingScreenState();
}

class _PressMeetingScreenState extends State<PressMeetingScreen> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final topics = [
      {'title': 'Economy', 'icon': Icons.trending_up, 'effects': {'economy': 2.0, 'mediaTrust': 3.0, 'approvalRating': 2.0}, 'text': 'You addressed the economy, reassuring markets and citizens.'},
      {'title': 'Security', 'icon': Icons.shield, 'effects': {'stability': 3.0, 'mediaTrust': 2.0, 'military': 1.0}, 'text': 'You addressed security concerns, boosting public confidence.'},
      {'title': 'Healthcare', 'icon': Icons.local_hospital, 'effects': {'health': 3.0, 'happiness': 2.0, 'approvalRating': 2.0}, 'text': 'You outlined healthcare improvements, earning public support.'},
      {'title': 'Education', 'icon': Icons.school, 'effects': {'education': 3.0, 'happiness': 2.0, 'mediaTrust': 2.0}, 'text': 'You committed to education reform, energizing young voters.'},
      {'title': 'Anti-Corruption', 'icon': Icons.gavel, 'effects': {'corruption': -3.0, 'mediaTrust': 5.0, 'approvalRating': 3.0}, 'text': 'You pledged to fight corruption, winning media praise.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.pressConference)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a topic for your press conference:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...topics.map((topic) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: _result == null ? () {
                  final effects = topic['effects'] as Map<String, double>;
                  for (final e in effects.entries) {
                    state.stats.applyStat(e.key, e.value);
                  }
                  state.stats.treasury -= 10;
                  state.diaryEntries.add('Month ${state.currentMonth}: Press conference on ${topic['title']}');
                  setState(() => _result = topic['text'] as String);
                } : null,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryLight),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(topic['icon'] as IconData, color: AppTheme.accent),
                      const SizedBox(width: 16),
                      Text(topic['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            )),
            if (_result != null) ...[
              const SizedBox(height: 24),
              Card(
                color: AppTheme.info.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(_result!, style: const TextStyle(color: AppTheme.info)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
