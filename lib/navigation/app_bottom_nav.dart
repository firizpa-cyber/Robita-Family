import 'package:flutter/material.dart';

import '../core/theme/app_insets.dart';
import '../widgets/app_animated_icon.dart';
import 'nav_destinations.dart';

/// Кастомный нижний навбар с самой плавной анимацией иконок.
///
/// Что анимируется при переключении:
/// - иконка: cross-fade outlined -> filled + scale (easeInOutCubic, 280ms)
/// - пилюля-индикатор: плавно расширяется/сужается
/// - подпись: плавно меняет цвет и жирность
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.destinations,
    required this.onTap,
  });

  final int currentIndex;
  final List<NavDestination> destinations;
  final ValueChanged<int> onTap;

  static const _duration = Duration(milliseconds: 280);
  static const _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(
            top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppInsets.sm,
          AppInsets.sm,
          AppInsets.sm,
          AppInsets.sm,
        ),
        child: Row(
          children: [
            for (int i = 0; i < destinations.length; i++)
              Expanded(
                child: _NavItem(
                  destination: destinations[i],
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  static const _duration = AppBottomNav._duration;
  static const _curve = AppBottomNav._curve;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Пилюля-индикатор с иконкой внутри — плавно меняет ширину/цвет.
          AnimatedContainer(
            duration: _duration,
            curve: _curve,
            padding: EdgeInsets.symmetric(
              horizontal: selected ? 20 : 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? scheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
            ),
            // Иконка из библиотеки: scale + cross-fade outlined/filled.
            child: AnimatedScale(
              scale: selected ? 1.05 : 1.0,
              duration: _duration,
              curve: _curve,
              child: AppAnimatedIcon(
                icon: selected
                    ? destination.filledIcon
                    : destination.outlinedIcon,
                selected: selected,
                color: selected
                    ? scheme.onPrimaryContainer
                    : scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Подпись: плавная смена цвета/жирности.
          AnimatedDefaultTextStyle(
            duration: _duration,
            curve: _curve,
            style:
                (textTheme.labelSmall ?? const TextStyle(fontSize: 12)).copyWith(
                  color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
            child: Text(destination.label, maxLines: 1),
          ),
        ],
      ),
    );
  }
}
