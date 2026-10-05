import 'package:flutter/material.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';

/// Индикатор батареи с цветовой индикацией по ТЗ:
/// зелёный (>50%), жёлтый (21–50%), красный (<=20%).
class BatteryIndicator extends StatelessWidget {
  const BatteryIndicator({super.key, required this.level});

  final double level;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.batteryLevel(level);
    final percent = (level * 100).round();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.battery_std_rounded, size: 18, color: color),
            const SizedBox(width: 2),
            Text(
              '$percent%',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: 72,
          height: 6,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(100),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: level.clamp(0.05, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppInsets.xs),
      ],
    );
  }
}
