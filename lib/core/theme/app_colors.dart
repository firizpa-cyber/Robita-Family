import 'package:flutter/material.dart';

/// Фирменные цвета Robita Life.
/// Держим все цвета в одном месте, чтобы не хардкодить по экранам.
abstract final class AppColors {
  static const Color seed = Color(0xFF4C6FFF);

  static const Color success = Color(0xFF22B47E);
  static const Color warning = Color(0xFFF5A524);
  static const Color danger = Color(0xFFF31260);

  static const Color batteryHigh = Color(0xFF22B47E);
  static const Color batteryMedium = Color(0xFFF5A524);
  static const Color batteryLow = Color(0xFFF31260);

  static Color batteryLevel(double level) {
    if (level > 0.5) return batteryHigh;
    if (level > 0.2) return batteryMedium;
    return batteryLow;
  }
}
