import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';
import 'package:robita_life/widgets/app_empty_view.dart';

/// Этап 1: пустая заглушка. Мессенджер — Этап 6 (Модуль 6 ТЗ).
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return AppEmptyView(
      icon: Icons.chat_bubble_outline,
      title: t.chatTitle,
      message: t.chatSubtitle,
      accent: const Color(0xFF00A8CC),
      badge: t.soonBadge,
    );
  }
}
