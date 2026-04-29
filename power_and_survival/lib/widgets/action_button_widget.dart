import 'package:flutter/material.dart';
import '../config/theme.dart';

class ActionButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const ActionButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Material(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: AppTheme.accent),
                const SizedBox(height: 6),
                Text(label, style: AppTheme.bodyStyle(size: 11, weight: FontWeight.w600), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
