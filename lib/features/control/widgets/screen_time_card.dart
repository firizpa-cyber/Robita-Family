import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';

/// Карточка экранного времени: кольцо прогресса + слайдер дневного лимита.
class ScreenTimeCard extends StatefulWidget {
  const ScreenTimeCard({
    super.key,
    required this.usedMinutes,
    required this.initialLimit,
  });

  final int usedMinutes;
  final int initialLimit;

  @override
  State<ScreenTimeCard> createState() => _ScreenTimeCardState();
}

class _ScreenTimeCardState extends State<ScreenTimeCard> {
  late int _limit = widget.initialLimit;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final progress = (widget.usedMinutes / _limit).clamp(0.0, 1.0);
    final over = widget.usedMinutes >= _limit;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.screenTime,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppInsets.md),
          Row(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 12,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.4),
                        valueColor: AlwaysStoppedAnimation(
                          over ? AppColors.danger : AppColors.seed,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _format(t, widget.usedMinutes),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          t.todayUsed,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppInsets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dailyLimit,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Text(
                      _format(t, _limit),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Slider(
            value: _limit.toDouble(),
            min: 60,
            max: 480,
            divisions: 28,
            label: _format(t, _limit),
            onChanged: (v) => setState(() => _limit = v.round()),
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
