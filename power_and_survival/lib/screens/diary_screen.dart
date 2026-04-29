import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    final entries = state?.diaryEntries ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Presidential Diary')),
      body: entries.isEmpty
          ? Center(child: Text('No diary entries yet.', style: AppTheme.bodyStyle(size: 14, color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final entry = entries[entries.length - 1 - i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: AppTheme.cardDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.book, size: 14, color: AppTheme.accent),
                          const SizedBox(width: 6),
                          Text('Entry ${entries.length - i}', style: AppTheme.bodyStyle(size: 11, color: AppTheme.accent)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(entry, style: AppTheme.bodyStyle(size: 12)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
