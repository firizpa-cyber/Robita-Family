import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';
import '../model/geo_models.dart';

/// Список геозон с настройкой радиуса слайдером.
class ZonesCard extends StatelessWidget {
  const ZonesCard({
    super.key,
    required this.zones,
    required this.onRadiusChanged,
  });

  final List<GeoZone> zones;
  final void Function(String id, double radius) onRadiusChanged;

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
              t.safeZones,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          for (final zone in zones)
            _ZoneRow(
              zone: zone,
              title: _zoneTitle(t, zone.id),
              onRadiusChanged: onRadiusChanged,
            ),
          const SizedBox(height: AppInsets.sm),
        ],
      ),
    );
  }

  String _zoneTitle(AppLocalizations t, String id) {
    switch (id) {
      case 'home':
        return t.zoneHome;
      case 'school':
        return t.zoneSchool;
      case 'club':
        return t.zoneClub;
      default:
        return id;
    }
  }
}

class _ZoneRow extends StatelessWidget {
  const _ZoneRow({
    required this.zone,
    required this.title,
    required this.onRadiusChanged,
  });

  final GeoZone zone;
  final String title;
  final void Function(String id, double radius) onRadiusChanged;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppInsets.md,
        vertical: AppInsets.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: zone.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppInsets.sm),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                t.radiusValue(zone.radiusMeters.round()),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: zone.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Slider(
            value: zone.radiusMeters,
            min: 50,
            max: 500,
            divisions: 45,
            activeColor: zone.color,
            onChanged: (v) => onRadiusChanged(zone.id, v),
          ),
        ],
      ),
    );
  }
}
