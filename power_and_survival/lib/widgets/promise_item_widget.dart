import 'package:flutter/material.dart';
import '../models/promise.dart';
import '../config/theme.dart';

class PromiseItemWidget extends StatelessWidget {
  final Promise promise;
  final int currentMonth;

  const PromiseItemWidget({super.key, required this.promise, required this.currentMonth});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    if (promise.isKept) {
      statusColor = AppTheme.success;
      statusText = 'KEPT';
    } else if (promise.isBroken) {
      statusColor = AppTheme.danger;
      statusText = 'BROKEN';
    } else {
      final remaining = promise.deadlineMonth - currentMonth;
      if (remaining <= 3) {
        statusColor = AppTheme.warning;
        statusText = '$remaining months left';
      } else {
        statusColor = AppTheme.textSecondary;
        statusText = '$remaining months left';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            promise.isKept ? Icons.check_circle : (promise.isBroken ? Icons.cancel : Icons.schedule),
            size: 18,
            color: statusColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(promise.text, style: AppTheme.bodyStyle(size: 12)),
                Text(statusText, style: AppTheme.bodyStyle(size: 10, color: statusColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
