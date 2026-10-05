import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

/// Библиотека анимированных иконок Robita Life.
///
/// Два режима:
/// 1. Material-иконка с микро-анимацией (из коробки, без файлов):
/// ```dart
/// AppAnimatedIcon(icon: Icons.map, selected: true)
/// ```
/// 2. Lottie-анимация (когда скачаешь .json в assets/lottie/):
/// ```dart
/// AppAnimatedIcon.lottie(asset: 'assets/lottie/map.json', selected: true)
/// ```
class AppAnimatedIcon extends StatelessWidget {
  const AppAnimatedIcon({
    super.key,
    required this.icon,
    required this.selected,
    this.size = 24,
    this.color,
  }) : lottieAsset = null;

  const AppAnimatedIcon.lottie({
    super.key,
    required String asset,
    required this.selected,
    this.size = 28,
    this.color,
  }) : lottieAsset = asset,
       icon = null;

  final IconData? icon;
  final String? lottieAsset;
  final bool selected;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // Режим Lottie: проигрывает анимацию при выборе.
    if (lottieAsset != null) {
      return Lottie.asset(
        lottieAsset!,
        width: size,
        height: size,
        repeat: false,
        animate: selected,
        // Ключ перезапускает анимацию при каждом тапе.
        key: ValueKey<bool>(selected),
      );
    }

    // Режим Material + flutter_animate: иконка всегда видима,
    // при смене выбора проигрывается pop-анимация один раз вперёд.
    return Icon(icon, size: size, color: color)
        .animate(key: ValueKey<bool>(selected))
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1.0, 1.0),
          duration: 250.ms,
          curve: Curves.easeInOutCubic,
        )
        .fadeIn(duration: 150.ms, curve: Curves.easeOut);
  }
}
