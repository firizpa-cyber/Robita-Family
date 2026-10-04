import 'package:flutter/material.dart';

/// Единые отступы / радиусы / размеры.
/// Используем везде вместо магических чисел.
abstract final class AppInsets {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;

  static const EdgeInsets page = EdgeInsets.all(md);
  static const EdgeInsets card = EdgeInsets.all(md);
}

abstract final class AppSizes {
  static const double emptyIcon = 64;
  static const double navIcon = 24;
}
