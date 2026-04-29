import 'package:flutter/material.dart';
import '../config/theme.dart';

class StatBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final bool invertColor;

  const StatBarWidget({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 100,
    this.invertColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedValue = (value / maxValue).clamp(0.0, 1.0);
    final color = invertColor
        ? AppTheme.getRiskColor(value)
        : AppTheme.getStatColor(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: normalizedValue,
              backgroundColor: AppTheme.primaryMid,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
