import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';
import 'package:robita_life/widgets/app_empty_view.dart';

/// Этап 1: пустая заглушка. Карта — на Этапе 3 (Модуль 3 ТЗ).
class LocatorScreen extends StatelessWidget {
  const LocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AppEmptyView(
      icon: Icons.map_outlined,
      title: t.locatorTitle,
      message: t.locatorSubtitle,
      accent: const Color(0xFF22B47E),
      badge: t.soonBadge,
    );
  }
}
