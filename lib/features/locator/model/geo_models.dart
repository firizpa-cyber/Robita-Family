import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Метка члена семьи на карте (Модуль 3 ТЗ).
class FamilyPin {
  const FamilyPin({
    required this.name,
    required this.position,
    required this.avatarColor,
    required this.isOnline,
  });

  final String name;
  final LatLng position;
  final Color avatarColor;
  final bool isOnline;

  String get initials => name.characters.first.toUpperCase();
}

/// Точка маршрута с временной меткой.
class RoutePoint {
  const RoutePoint({required this.time, required this.position});

  final String time;
  final LatLng position;
}

/// Безопасная геозона с настраиваемым радиусом.
class GeoZone {
  GeoZone({
    required this.id,
    required this.center,
    required this.radiusMeters,
    required this.color,
  });

  final String id;
  final LatLng center;
  double radiusMeters;
  final Color color;
}
