import 'package:flutter/material.dart';

import 'package:robita_life/core/theme/app_insets.dart';
import 'data/summary_mock.dart';
import 'widgets/family_status_card.dart';
import 'widgets/sos_card.dart';
import 'widgets/today_tasks_card.dart';

/// Сводка семьи — главный дашборд (Модуль 2 ТЗ).
/// Водяной фон: градиент + мягкие пятна, поверх — стеклянные карточки.
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Водяной фон.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                scheme.primaryContainer.withValues(alpha: 0.55),
                scheme.surface,
              ],
            ),
          ),
        ),
        Positioned(
          top: -70,
          right: -60,
          child: _Blob(
            size: 220,
            color: scheme.primary.withValues(alpha: 0.22),
          ),
        ),
        Positioned(
          top: 140,
          left: -80,
          child: _Blob(
            size: 180,
            color: scheme.tertiary.withValues(alpha: 0.18),
          ),
        ),
        // Контент.
        SingleChildScrollView(
          padding: const EdgeInsets.all(AppInsets.md),
          child: Column(
            children: [
              const FamilyStatusCard(members: SummaryMock.members),
              const SizedBox(height: AppInsets.md),
              const SosCard(),
              const SizedBox(height: AppInsets.md),
              TodayTasksCard(initialTasks: SummaryMock.todayTasks()),
              const SizedBox(height: AppInsets.md),
            ],
          ),
        ),
      ],
    );
  }
}

/// Мягкое круглое пятно для водяного фона.
class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
