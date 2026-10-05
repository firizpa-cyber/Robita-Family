import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';

/// Ручная жёсткая блокировка устройства с демо-экраном блокировки.
/// Экстренные вызовы остаются доступны.
class BlockCard extends StatelessWidget {
  const BlockCard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppInsets.radiusMd),
            ),
            child: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.danger,
              size: 28,
            ),
          ),
          const SizedBox(width: AppInsets.md),
          Expanded(
            child: Text(
              t.blockDevice,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const LockOverlay(),
              ),
            ),
            child: const Icon(Icons.lock_rounded),
          ),
        ],
      ),
    );
  }
}

/// Демо экрана блокировки ребёнка.
class LockOverlay extends StatelessWidget {
  const LockOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF14141A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppInsets.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppInsets.lg),
              Text(
                t.deviceLocked,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppInsets.sm),
              Text(
                t.lockedHint,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppInsets.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(t.emergencyStarted)),
                      );
                  },
                  icon: const Icon(Icons.call_rounded),
                  label: Text(t.emergencyCall),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: AppInsets.sm),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white38),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(t.unlockByParent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
