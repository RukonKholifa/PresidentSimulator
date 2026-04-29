import 'package:flutter/material.dart';
import '../config/theme.dart';

class RiskBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;

  const RiskBarWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final pct = (value / 100).clamp(0.0, 1.0);
    final color = AppTheme.getRiskColor(value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: Text(label, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
          ),
          Expanded(
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: AppTheme.cardBorder,
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: pct,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 28,
            child: Text(
              '${value.toStringAsFixed(0)}%',
              style: AppTheme.bodyStyle(size: 10, weight: FontWeight.w600, color: color),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
