import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';
import '../model/geo_models.dart';

/// Таймлайн истории перемещений: от точки А до точки Б с временными метками.
class RouteCard extends StatelessWidget {
  const RouteCard({
    super.key,
    required this.route,
    required this.showRoute,
    required this.onToggle,
  });

  final List<RoutePoint> route;
  final bool showRoute;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${t.routeHistory} • Али',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Switch.adaptive(value: showRoute, onChanged: onToggle),
            ],
          ),
          if (showRoute) ...[
            const SizedBox(height: AppInsets.sm),
            Row(
              children: [
                for (int i = 0; i < route.length; i++) ...[
                  _TimeDot(point: route[i], isEdge: i == 0 || i == route.length - 1),
                  if (i < route.length - 1)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Divider(
                          thickness: 2,
                          color: AppColors.seed,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TimeDot extends StatelessWidget {
  const _TimeDot({required this.point, required this.isEdge});

  final RoutePoint point;
  final bool isEdge;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isEdge ? 16 : 12,
          height: isEdge ? 16 : 12,
          decoration: BoxDecoration(
            color: isEdge ? AppColors.seed : AppColors.seed.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          point.time,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
