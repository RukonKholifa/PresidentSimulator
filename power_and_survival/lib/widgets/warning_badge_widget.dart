import 'package:flutter/material.dart';
import '../config/theme.dart';

class WarningBadgeWidget extends StatelessWidget {
  final String text;
  final double riskLevel;

  const WarningBadgeWidget({
    super.key,
    required this.text,
    required this.riskLevel,
  });

  @override
  Widget build(BuildContext context) {
    if (riskLevel < 50) return const SizedBox.shrink();

    final color = riskLevel >= 70 ? AppTheme.danger : AppTheme.warning;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text(text, style: AppTheme.bodyStyle(size: 11, weight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
