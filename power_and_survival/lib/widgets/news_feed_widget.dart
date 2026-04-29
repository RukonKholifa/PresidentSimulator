import 'package:flutter/material.dart';
import '../config/theme.dart';

class NewsFeedWidget extends StatelessWidget {
  final List<String> headlines;
  final int maxItems;

  const NewsFeedWidget({
    super.key,
    required this.headlines,
    this.maxItems = 5,
  });

  @override
  Widget build(BuildContext context) {
    final displayItems = headlines.length > maxItems
        ? headlines.sublist(headlines.length - maxItems)
        : headlines;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.newspaper, size: 18, color: AppTheme.accent),
                SizedBox(width: 8),
                Text('NEWS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.accent)),
              ],
            ),
            const Divider(color: AppTheme.primaryLight),
            ...displayItems.reversed.map((headline) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppTheme.accent)),
                  Expanded(
                    child: Text(
                      headline,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, height: 1.3),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
