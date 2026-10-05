import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import '../model/geo_models.dart';

/// Интерактивная карта семьи: фото-метки, маршрут и геозоны.
/// Тайлы OpenStreetMap — ключи API не нужны.
class FamilyMap extends StatelessWidget {
  const FamilyMap({
    super.key,
    required this.controller,
    required this.pins,
    required this.zones,
    required this.showRoute,
    required this.route,
    required this.selectedPin,
    required this.onPinTap,
  });

  final MapController controller;
  final List<FamilyPin> pins;
  final List<GeoZone> zones;
  final bool showRoute;
  final List<RoutePoint> route;
  final int selectedPin;
  final ValueChanged<int> onPinTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppInsets.radiusLg),
      child: SizedBox(
        height: 340,
        child: FlutterMap(
          mapController: controller,
          options: const MapOptions(
            initialCenter: LatLng(41.3111, 69.2797),
            initialZoom: 14,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.robita.life',
            ),
            CircleLayer(
              circles: [
                for (final zone in zones)
                  CircleMarker(
                    point: zone.center,
                    radius: zone.radiusMeters,
                    useRadiusInMeter: true,
                    color: zone.color.withValues(alpha: 0.15),
                    borderColor: zone.color.withValues(alpha: 0.7),
                    borderStrokeWidth: 2,
                  ),
              ],
            ),
            if (showRoute)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [for (final p in route) p.position],
                    color: AppColors.seed,
                    strokeWidth: 4,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                for (int i = 0; i < pins.length; i++)
                  Marker(
                    point: pins[i].position,
                    width: 64,
                    height: 64,
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => onPinTap(i),
                      child: _PinBubble(
                        pin: pins[i],
                        selected: i == selectedPin,
                      ),
                    ),
                  ),
                if (showRoute)
                  for (final p in [route.first, route.last])
                    Marker(
                      point: p.position,
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: _RouteDot(time: p.time),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Круглая фото-метка с именем и точкой онлайна.
class _PinBubble extends StatelessWidget {
  const _PinBubble({required this.pin, required this.selected});

  final FamilyPin pin;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: selected ? 46 : 38,
              height: selected ? 46 : 38,
              decoration: BoxDecoration(
                color: pin.avatarColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                pin.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: pin.isOnline ? AppColors.success : scheme.outline,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: selected ? pin.avatarColor : Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Text(
            pin.name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

/// Точка А / Б маршрута с временной меткой.
class _RouteDot extends StatelessWidget {
  const _RouteDot({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.seed,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
