import 'package:flutter/material.dart';

import 'package:robita_life/core/theme/app_insets.dart';
import 'data/control_mock.dart';
import 'widgets/app_limits_card.dart';
import 'widgets/block_card.dart';
import 'widgets/protection_card.dart';
import 'widgets/screen_time_card.dart';
import 'widgets/web_filter_card.dart';

/// Контроль — экранное время и ограничения (Модуль 4 ТЗ).
/// Статистика, лимиты, блокировка, веб-фильтры и защита от обхода.
class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppInsets.md),
      child: Column(
        children: [
          const ScreenTimeCard(
            usedMinutes: ControlMock.totalUsedMinutes,
            initialLimit: ControlMock.totalLimitMinutes,
          ),
          const SizedBox(height: AppInsets.md),
          AppLimitsCard(usages: ControlMock.appUsages()),
          const SizedBox(height: AppInsets.md),
          const BlockCard(),
          const SizedBox(height: AppInsets.md),
          WebFilterCard(
            initialBlacklist: ControlMock.blacklist(),
            initialWhitelist: ControlMock.whitelist(),
          ),
          const SizedBox(height: AppInsets.md),
          const ProtectionCard(),
          const SizedBox(height: AppInsets.md),
        ],
      ),
    );
  }
}
