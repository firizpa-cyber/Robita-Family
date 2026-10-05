import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';
import 'package:robita_life/widgets/app_empty_view.dart';

/// Этап 1: пустая заглушка. Календарь и задачи — Этап 5 (Модуль 5 ТЗ).
class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AppEmptyView(
      icon: Icons.calendar_month_outlined,
      title: t.plansTitle,
      message: t.plansSubtitle,
      accent: const Color(0xFF7C4DFF),
      badge: t.soonBadge,
    );
  }
}
