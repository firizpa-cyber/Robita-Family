import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import '../features/chat/chat_screen.dart';
import '../features/control/control_screen.dart';
import '../features/locator/locator_screen.dart';
import '../features/plans/plans_screen.dart';
import '../features/summary/summary_screen.dart';
import 'nav_destinations.dart';
import 'app_bottom_nav.dart';

/// Главный каркас приложения: AppBar + контент + нижнее меню.
///
/// 5 разделов строго по ТЗ (п.4):
/// Сводка / Локатор / Контроль / Планы / Чат
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    SummaryScreen(),
    LocatorScreen(),
    ControlScreen(),
    PlansScreen(),
    ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final destinations = _destinations(t);

    return Scaffold(
      appBar: AppBar(title: Text(_pageTitle(t, _currentIndex))),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        destinations: destinations,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  List<NavDestination> _destinations(AppLocalizations t) => [
    NavDestination(
      outlinedIcon: Icons.dashboard_outlined,
      filledIcon: Icons.dashboard_rounded,
      label: t.summaryNav,
    ),
    NavDestination(
      outlinedIcon: Icons.map_outlined,
      filledIcon: Icons.map_rounded,
      label: t.locatorNav,
    ),
    NavDestination(
      outlinedIcon: Icons.shield_outlined,
      filledIcon: Icons.shield_rounded,
      label: t.controlNav,
    ),
    NavDestination(
      outlinedIcon: Icons.calendar_month_outlined,
      filledIcon: Icons.calendar_month_rounded,
      label: t.plansNav,
    ),
    NavDestination(
      outlinedIcon: Icons.chat_bubble_outline,
      filledIcon: Icons.chat_bubble_rounded,
      label: t.chatNav,
    ),
  ];

  /// Крупный человеческий заголовок для AppBar — видно на каждой странице.
  String _pageTitle(AppLocalizations t, int index) {
    switch (index) {
      case 0:
        return t.summaryTitle;
      case 1:
        return t.locatorTitle;
      case 2:
        return t.controlTitle;
      case 3:
        return t.plansTitle;
      case 4:
        return t.chatTitle;
      default:
        return t.appTitle;
    }
  }
}
