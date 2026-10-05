import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';
import '../model/app_usage.dart';

/// Лимиты приложений: статистика использования + настройка лимитов.
class AppLimitsCard extends StatefulWidget {
  const AppLimitsCard({super.key, required this.usages});

  final List<AppUsage> usages;

  @override
  State<AppLimitsCard> createState() => _AppLimitsCardState();
}

class _AppLimitsCardState extends State<AppLimitsCard> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppInsets.md,
              AppInsets.md,
              AppInsets.md,
              AppInsets.sm,
            ),
            child: Text(
              t.appLimits,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (final app in widget.usages) _AppRow(app: app, onChanged: _refresh),
          const SizedBox(height: AppInsets.sm),
        ],
      ),
    );
  }

  void _refresh() => setState(() {});
}

class _AppRow extends StatelessWidget {
  const _AppRow({required this.app, required this.onChanged});

  final AppUsage app;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.md,
        vertical: AppInsets.sm,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: app.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppInsets.radiusSm),
                ),
                child: Icon(app.icon, color: app.color),
              ),
              const SizedBox(width: AppInsets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _format(t, app.minutesUsed),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: app.isOverLimit
                            ? AppColors.danger
                            : Theme.of(context).colorScheme.outline,
                        fontWeight: app.isOverLimit
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: app.limitMinutes == null
                    ? null
                    : () {
                        final next = app.limitMinutes! - 15;
                        app.limitMinutes = next <= 0 ? null : next;
                        onChanged();
                      },
              ),
              SizedBox(
                width: 76,
                child: Text(
                  app.limitMinutes == null
                      ? t.limitOff
                      : _format(t, app.limitMinutes!),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: app.isOverLimit
                        ? AppColors.danger
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  app.limitMinutes = (app.limitMinutes ?? 0) + 15;
                  if (app.limitMinutes! > 240) app.limitMinutes = 240;
                  onChanged();
                },
              ),
            ],
          ),
          const SizedBox(height: AppInsets.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              // Без лимита показываем пустую шкалу 0, а не бесконечную
              // анимацию — иначе тесты с pumpAndSettle никогда не завершатся.
              value: app.limitMinutes == null ? 0 : app.progress,
              minHeight: 6,
              backgroundColor: app.color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation(
                app.isOverLimit ? AppColors.danger : app.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _format(AppLocalizations t, int minutes) {
    if (minutes < 60) return t.minutesShort(minutes);
    return t.hoursShort(minutes ~/ 60, minutes % 60);
  }
}
