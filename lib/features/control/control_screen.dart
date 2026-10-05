import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';
import 'package:robita_life/widgets/app_empty_view.dart';

/// Этап 1: пустая заглушка. Экранное время и лимиты — Этап 4 (Модуль 4 ТЗ).
class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AppEmptyView(
      icon: Icons.shield_outlined,
      title: t.controlTitle,
      message: t.controlSubtitle,
      accent: const Color(0xFFF5A524),
      badge: t.soonBadge,
    );
  }
}
