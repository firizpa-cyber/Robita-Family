import 'package:flutter/material.dart';

import '../core/theme/app_insets.dart';

/// Красивая заглушка раздела: крупная надпись + описание + бейдж.
/// Используется всеми 5 экранами на Этапе 1, потом заменим на реальный контент.
///
/// Пример:
/// ```dart
/// AppEmptyView(icon: Icons.map_outlined, title: 'Карта семьи', message: '...')
/// ```
class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.accent,
    this.badge,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color? accent;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final color = accent ?? scheme.primary;

    return Center(
      child: Padding(
        padding: AppInsets.page,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppInsets.radiusLg),
              ),
              child: Icon(icon, size: 44, color: color),
            ),
            const SizedBox(height: AppInsets.lg),
            Text(
              title,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppInsets.sm),
            Text(
              message,
              style: textTheme.bodyLarge?.copyWith(color: scheme.outline),
              textAlign: TextAlign.center,
            ),
            if (badge != null) ...[
              const SizedBox(height: AppInsets.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.md,
                  vertical: AppInsets.xs,
                ),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  badge!,
                  style: textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
