import 'package:flutter/material.dart';

/// Член семьи для блока статусов (Модуль 2 ТЗ).
/// Пока данные моковые, позже придут из API.
class FamilyMember {
  const FamilyMember({
    required this.name,
    required this.role,
    required this.avatarColor,
    required this.battery,
    this.isOnline = false,
    this.lastSeenMinutes,
  });

  final String name;
  final String role;
  final Color avatarColor;
  final double battery;
  final bool isOnline;
  final int? lastSeenMinutes;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts[0].characters.first + parts[1].characters.first)
        .toUpperCase();
  }

  bool get isLowBattery => battery <= 0.2;
}
