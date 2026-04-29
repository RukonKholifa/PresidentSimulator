import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    if (riskLevel < 60) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.danger.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.danger.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_amber, size: 14, color: AppTheme.danger),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.danger,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .fadeIn(duration: 800.ms)
     .then()
     .fadeOut(duration: 800.ms);
  }
}
