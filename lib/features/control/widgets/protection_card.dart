import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';

/// Защита от обхода: переключатели системных политик.
class ProtectionCard extends StatefulWidget {
  const ProtectionCard({super.key});

  @override
  State<ProtectionCard> createState() => _ProtectionCardState();
}

class _ProtectionCardState extends State<ProtectionCard> {
  bool _noUninstall = true;
  bool _noTimeChange = true;
  bool _noGeoOff = false;

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
              AppInsets.xs,
            ),
            child: Text(
              t.protection,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SwitchListTile(
            value: _noUninstall,
            onChanged: (v) => setState(() => _noUninstall = v),
            title: Text(t.preventUninstall),
            secondary: const Icon(Icons.phonelink_lock_outlined),
          ),
          SwitchListTile(
            value: _noTimeChange,
            onChanged: (v) => setState(() => _noTimeChange = v),
            title: Text(t.preventTimeChange),
            secondary: const Icon(Icons.schedule_outlined),
          ),
          SwitchListTile(
            value: _noGeoOff,
            onChanged: (v) => setState(() => _noGeoOff = v),
            title: Text(t.preventGeoOff),
            secondary: const Icon(Icons.location_off_outlined),
          ),
          const SizedBox(height: AppInsets.sm),
        ],
      ),
    );
  }
}
