import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';
import 'package:robita_life/widgets/app_empty_view.dart';

/// Этап 1: пустая заглушка. Реальный дашборд — на Этапе 2 (Модуль 2 ТЗ).
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AppEmptyView(
      icon: Icons.family_restroom_outlined,
      title: t.summaryTitle,
      message: t.summarySubtitle,
      accent: const Color(0xFF4C6FFF),
      badge: t.soonBadge,
    );
  }
}
