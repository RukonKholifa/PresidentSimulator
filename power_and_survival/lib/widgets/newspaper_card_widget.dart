import 'package:flutter/material.dart';
import '../config/theme.dart';

class NewspaperCardWidget extends StatelessWidget {
  final String headline;
  final String? date;

  const NewspaperCardWidget({super.key, required this.headline, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          const Icon(Icons.article, size: 18, color: AppTheme.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headline, style: AppTheme.bodyStyle(size: 12)),
                if (date != null) Text(date!, style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
