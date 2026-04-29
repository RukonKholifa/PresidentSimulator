import 'package:flutter/material.dart';
import '../config/theme.dart';

class AdvisorCommentWidget extends StatelessWidget {
  final String advisorName;
  final String comment;
  final IconData icon;
  final Color? accentColor;

  const AdvisorCommentWidget({
    super.key,
    required this.advisorName,
    required this.comment,
    this.icon = Icons.person,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppTheme.accent;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.2),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(advisorName, style: AppTheme.bodyStyle(size: 11, weight: FontWeight.w700, color: color)),
                const SizedBox(height: 2),
                Text(comment, style: AppTheme.bodyStyle(size: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
