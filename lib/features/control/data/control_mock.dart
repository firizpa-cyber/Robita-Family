import 'package:flutter/material.dart';

import '../model/app_usage.dart';

/// Моковые данные Контроля. Позже — системная статистика и MDM-политики.
abstract final class ControlMock {
  static const int totalUsedMinutes = 222;
  static const int totalLimitMinutes = 300;

  static List<AppUsage> appUsages() => [
    AppUsage(
      name: 'TikTok',
      icon: Icons.music_note_rounded,
      color: const Color(0xFF111111),
      minutesUsed: 80,
      limitMinutes: 60,
    ),
    AppUsage(
      name: 'YouTube',
      icon: Icons.play_circle_fill_rounded,
      color: const Color(0xFFE62117),
      minutesUsed: 58,
      limitMinutes: 90,
    ),
    AppUsage(
      name: 'Игры',
      icon: Icons.sports_esports_rounded,
      color: const Color(0xFF7C4DFF),
      minutesUsed: 47,
    ),
    AppUsage(
      name: 'Учёба',
      icon: Icons.school_rounded,
      color: const Color(0xFF22B47E),
      minutesUsed: 37,
    ),
  ];

  static List<String> blacklist() => ['bad-site.com', 'ads-tracker.net'];

  static List<String> whitelist() => ['school.edu', 'kids-library.org'];
}
