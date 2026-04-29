import 'package:flutter/material.dart';
import '../models/promise.dart';
import '../config/theme.dart';

class PromiseItemWidget extends StatelessWidget {
  final Promise promise;
  final int currentMonth;

  const PromiseItemWidget({
    super.key,
    required this.promise,
    required this.currentMonth,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    if (promise.isKept) {
      statusColor = AppTheme.success;
      statusText = 'KEPT';
      statusIcon = Icons.check_circle;
    } else if (promise.isBroken) {
      statusColor = AppTheme.danger;
      statusText = 'BROKEN';
      statusIcon = Icons.cancel;
    } else {
      final remaining = promise.deadlineMonth - currentMonth;
      if (remaining <= 3) {
        statusColor = AppTheme.warning;
        statusText = '$remaining months left';
        statusIcon = Icons.warning;
      } else {
        statusColor = AppTheme.info;
        statusText = '$remaining months left';
        statusIcon = Icons.schedule;
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor),
        title: Text(promise.text, style: const TextStyle(fontSize: 13)),
        subtitle: Text(
          '${promise.category} • $statusText',
          style: TextStyle(fontSize: 11, color: statusColor),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusText,
            style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
