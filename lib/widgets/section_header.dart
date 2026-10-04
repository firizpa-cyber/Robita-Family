import 'package:flutter/material.dart';

import '../core/theme/app_insets.dart';

/// Заголовок секции внутри экрана.
/// Чтобы все разделы выглядели одинаково.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppInsets.md,
        AppInsets.md,
        AppInsets.md,
        AppInsets.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
