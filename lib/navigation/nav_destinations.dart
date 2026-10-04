import 'package:flutter/material.dart';

/// Описание одной вкладки нижнего меню.
/// Вынесено в модель, чтобы MainLayout остался тонким и красивым.
class NavDestination {
  const NavDestination({
    required this.outlinedIcon,
    required this.filledIcon,
    required this.label,
  });

  final IconData outlinedIcon;
  final IconData filledIcon;
  final String label;
}
