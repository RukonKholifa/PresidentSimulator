import 'package:flutter/material.dart';
import '../config/theme.dart';

class NewsFeedWidget extends StatelessWidget {
  final List<String> headlines;

  const NewsFeedWidget({super.key, required this.headlines});

  @override
  Widget build(BuildContext context) {
    final recent = headlines.length > 5 ? headlines.sublist(headlines.length - 5) : headlines;

    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.newspaper, size: 16, color: AppTheme.accent),
              const SizedBox(width: 6),
              Text('Latest News', style: AppTheme.headerStyle(size: 14)),
            ],
          ),
          const Divider(color: AppTheme.cardBorder, height: 16),
          ...recent.reversed.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: AppTheme.accent, fontSize: 12)),
                Expanded(child: Text(h, style: AppTheme.bodyStyle(size: 12))),
              ],
            ),
          )),
          if (recent.isEmpty) Text('No news yet.', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
