import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';
import '../model/family_member.dart';
import 'battery_indicator.dart';

/// Блок «Семья сейчас»: карточки с фото, статусом сети и батареей.
/// Кнопка напоминания о зарядке — для разряженных устройств.
class FamilyStatusCard extends StatelessWidget {
  const FamilyStatusCard({super.key, required this.members});

  final List<FamilyMember> members;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppInsets.md,
              AppInsets.md,
              AppInsets.md,
              AppInsets.sm,
            ),
            child: Text(
              t.familyNow,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (int i = 0; i < members.length; i++) ...[
            if (i > 0) const Divider(height: 1, indent: AppInsets.md),
            _MemberTile(member: members[i]),
          ],
          const SizedBox(height: AppInsets.sm),
        ],
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});

  final FamilyMember member;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.md,
        vertical: AppInsets.sm,
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: member.avatarColor.withValues(alpha: 0.15),
                child: Text(
                  member.initials,
                  style: TextStyle(
                    color: member.avatarColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: member.isOnline
                        ? AppColors.success
                        : scheme.outline,
                    shape: BoxShape.circle,
                    border: Border.all(color: scheme.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppInsets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member.isOnline
                      ? t.onlineNow
                      : t.lastSeenMinutes(member.lastSeenMinutes ?? 0),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: member.isOnline
                        ? AppColors.success
                        : scheme.outline,
                    fontWeight: member.isOnline
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          BatteryIndicator(level: member.battery),
          if (member.isLowBattery)
            IconButton(
              tooltip: t.remindCharge,
              icon: const Icon(Icons.notifications_active_outlined),
              color: AppColors.danger,
              onPressed: () => ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(t.chargeReminderSent))),
            ),
        ],
      ),
    );
  }
}
