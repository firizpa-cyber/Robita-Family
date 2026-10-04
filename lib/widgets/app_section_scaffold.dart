import 'package:flutter/material.dart';

import '../core/theme/app_insets.dart';

/// Базовый каркас пустого экрана раздела.
/// Даёт единый SafeArea + скролл + паддинги всем feature-экранам.
class AppSectionScaffold extends StatelessWidget {
  const AppSectionScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: AppInsets.page,
        child: body,
      ),
    );
  }
}
