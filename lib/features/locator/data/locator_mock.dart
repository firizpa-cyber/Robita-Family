import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../model/geo_models.dart';

/// Моковые данные карты (Ташкент). Позже — трекинг в реальном времени.
abstract final class LocatorMock {
  static const LatLng cityCenter = LatLng(41.3111, 69.2797);

  static const pins = <FamilyPin>[
    FamilyPin(
      name: 'Папа',
      position: LatLng(41.3125, 69.2780),
      avatarColor: Color(0xFF4C6FFF),
      isOnline: true,
    ),
    FamilyPin(
      name: 'Мама',
      position: LatLng(41.3080, 69.2845),
      avatarColor: Color(0xFFFF6FA5),
      isOnline: true,
    ),
    FamilyPin(
      name: 'Али',
      position: LatLng(41.3155, 69.2900),
      avatarColor: Color(0xFF22B47E),
      isOnline: false,
    ),
    FamilyPin(
      name: 'Малика',
      position: LatLng(41.3050, 69.2720),
      avatarColor: Color(0xFF7C4DFF),
      isOnline: true,
    ),
  ];

  /// История перемещений Али: из точки А (Дом) в точку Б (Школа).
  static const route = <RoutePoint>[
    RoutePoint(time: '08:00', position: LatLng(41.3125, 69.2780)),
    RoutePoint(time: '08:10', position: LatLng(41.3140, 69.2840)),
    RoutePoint(time: '08:25', position: LatLng(41.3155, 69.2900)),
  ];

  static List<GeoZone> zones() => [
    GeoZone(
      id: 'home',
      center: const LatLng(41.3125, 69.2780),
      radiusMeters: 150,
      color: const Color(0xFF4C6FFF),
    ),
    GeoZone(
      id: 'school',
      center: const LatLng(41.3155, 69.2900),
      radiusMeters: 200,
      color: const Color(0xFF22B47E),
    ),
    GeoZone(
      id: 'club',
      center: const LatLng(41.3050, 69.2720),
      radiusMeters: 120,
      color: const Color(0xFFF5A524),
    ),
  ];
}
