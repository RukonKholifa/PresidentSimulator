import 'package:flutter/material.dart';
import '../config/theme.dart';

class StatBarWidget extends StatefulWidget {
  final String label;
  final double value;
  final double maxValue;
  final IconData? icon;
  final bool showDangerPulse;

  const StatBarWidget({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = 100,
    this.icon,
    this.showDangerPulse = true,
  });

  @override
  State<StatBarWidget> createState() => _StatBarWidgetState();
}

class _StatBarWidgetState extends State<StatBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.showDangerPulse && widget.value < 25) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(StatBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showDangerPulse && widget.value < 25) {
      if (!_pulseController.isAnimating) _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pct = (widget.value / widget.maxValue).clamp(0.0, 1.0);
    final color = AppTheme.getStatColor(widget.value);
    final isDanger = widget.showDangerPulse && widget.value < 25;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, size: 14, color: AppTheme.textSecondary),
            const SizedBox(width: 4),
          ],
          SizedBox(
            width: 80,
            child: Text(
              widget.label,
              style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              listenable: _pulseController,
              builder: (context, child) {
                final glowOpacity = isDanger ? (_pulseController.value * 0.6 + 0.2) : 0.0;
                return Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBorder,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: isDanger
                        ? [BoxShadow(color: AppTheme.danger.withValues(alpha: glowOpacity), blurRadius: 8, spreadRadius: 1)]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.centerLeft,
                      widthFactor: pct,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 32,
            child: Text(
              widget.value.toStringAsFixed(0),
              style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w600, color: color),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBuilder extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;

  const AnimatedBuilder({
    super.key,
    required super.listenable,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => builder(context, null);
}
