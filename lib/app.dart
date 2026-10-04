import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'navigation/main_layout.dart';

/// Корень приложения: тема + локализация + главный layout.
/// Вся конфигурация MaterialApp — только здесь.
class RobitaLifeApp extends StatelessWidget {
  const RobitaLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      locale: const Locale('ru'),
      home: const MainLayout(),
    );
  }
}
