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
    final color = AppTheme.getRiskColor(value);
    final normalizedValue = (value / 100).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: normalizedValue,
                backgroundColor: AppTheme.primaryMid,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              '${value.toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
