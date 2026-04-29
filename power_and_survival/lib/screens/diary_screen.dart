import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.presidentialDiary)),
      body: state.diaryEntries.isEmpty
          ? const Center(child: Text(StringsEn.noEntries, style: TextStyle(color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.diaryEntries.length,
              itemBuilder: (context, index) {
                final entry = state.diaryEntries[state.diaryEntries.length - 1 - index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.edit_note, size: 18, color: AppTheme.gold),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry, style: const TextStyle(fontSize: 13, height: 1.4))),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
