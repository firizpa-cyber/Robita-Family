import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:robita_life/core/theme/app_insets.dart';
import 'data/locator_mock.dart';
import 'widgets/family_map.dart';
import 'widgets/route_card.dart';
import 'widgets/zones_card.dart';

/// Локатор — карта семьи (Модуль 3 ТЗ).
/// Метки, история маршрута А→Б и геозоны с настраиваемым радиусом.
class LocatorScreen extends StatefulWidget {
  const LocatorScreen({super.key});

  @override
  State<LocatorScreen> createState() => _LocatorScreenState();
}

class _LocatorScreenState extends State<LocatorScreen> {
  final _mapController = MapController();
  final _zones = LocatorMock.zones();
  int _selectedPin = 2;
  bool _showRoute = true;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pins = LocatorMock.pins;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppInsets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: pins.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppInsets.sm),
              itemBuilder: (context, i) {
                final selected = i == _selectedPin;
                return ChoiceChip(
                  label: Text(pins[i].name),
                  selected: selected,
                  avatar: CircleAvatar(
                    radius: 10,
                    backgroundColor: pins[i].avatarColor,
                    child: Text(
                      pins[i].initials,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  onSelected: (_) => _selectPin(i),
                );
              },
            ),
          ),
          const SizedBox(height: AppInsets.md),
          FamilyMap(
            controller: _mapController,
            pins: pins,
            zones: _zones,
            showRoute: _showRoute,
            route: LocatorMock.route,
            selectedPin: _selectedPin,
            onPinTap: _selectPin,
          ),
          const SizedBox(height: AppInsets.md),
          RouteCard(
            route: LocatorMock.route,
            showRoute: _showRoute,
            onToggle: (v) => setState(() => _showRoute = v),
          ),
          const SizedBox(height: AppInsets.md),
          ZonesCard(
            zones: _zones,
            onRadiusChanged: (id, radius) => setState(() {
              _zones
                  .firstWhere((z) => z.id == id)
                  .radiusMeters = radius;
            }),
          ),
          const SizedBox(height: AppInsets.md),
        ],
      ),
    );
  }

  void _selectPin(int i) {
    setState(() => _selectedPin = i);
    _mapController.move(LocatorMock.pins[i].position, 15);
  }
}
