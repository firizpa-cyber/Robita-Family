import 'dart:async';

import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';

/// Тревожная кнопка SOS с защитой от случайных нажатий:
/// срабатывает только при удержании ровно 2 секунды.
/// Кольцо показывает прогресс удержания.
class SosCard extends StatefulWidget {
  const SosCard({super.key});

  @override
  State<SosCard> createState() => _SosCardState();
}

class _SosCardState extends State<SosCard> {
  static const _hold = Duration(seconds: 2);

  Timer? _timer;
  double _progress = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startHold() {
    _timer?.cancel();
    const tick = Duration(milliseconds: 50);
    var elapsed = Duration.zero;

    _timer = Timer.periodic(tick, (timer) {
      elapsed += tick;
      final p = (elapsed.inMilliseconds / _hold.inMilliseconds).clamp(
        0.0,
        1.0,
      );
      if (mounted) setState(() => _progress = p);
      if (p >= 1.0) {
        timer.cancel();
        _fire();
      }
    });
  }

  void _cancelHold() {
    _timer?.cancel();
    if (mounted && _progress > 0) setState(() => _progress = 0);
  }

  void _fire() {
    if (mounted) setState(() => _progress = 0);
    final t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(t.sosSent),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return GlassCard(
      child: Row(
        children: [
          GestureDetector(
            onTapDown: (_) => _startHold(),
            onTapUp: (_) => _cancelHold(),
            onTapCancel: _cancelHold,
            child: SizedBox(
              width: 112,
              height: 112,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 112,
                    height: 112,
                    child: CircularProgressIndicator(
                      value: _progress == 0 ? 0 : _progress,
                      strokeWidth: 8,
                      backgroundColor: AppColors.danger.withValues(alpha: 0.15),
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.danger,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Container(
                    width: 88,
                    height: 88,
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppInsets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.sosTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppInsets.xs),
                Text(
                  t.sosHoldHint,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
