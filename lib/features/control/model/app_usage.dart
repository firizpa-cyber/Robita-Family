import 'package:flutter/material.dart';

/// Использование приложения ребёнком (Модуль 4 ТЗ).
class AppUsage {
  AppUsage({
    required this.name,
    required this.icon,
    required this.color,
    required this.minutesUsed,
    this.limitMinutes,
  });

  final String name;
  final IconData icon;
  final Color color;
  final int minutesUsed;
  int? limitMinutes;

  double get progress =>
      limitMinutes == null || limitMinutes == 0
      ? 0
      : (minutesUsed / limitMinutes!).clamp(0.0, 1.0);

  bool get isOverLimit =>
      limitMinutes != null && minutesUsed >= limitMinutes!;
}
