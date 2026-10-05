import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';

/// Белые и чёрные списки сайтов.
class WebFilterCard extends StatefulWidget {
  const WebFilterCard({
    super.key,
    required this.initialBlacklist,
    required this.initialWhitelist,
  });

  final List<String> initialBlacklist;
  final List<String> initialWhitelist;

  @override
  State<WebFilterCard> createState() => _WebFilterCardState();
}

class _WebFilterCardState extends State<WebFilterCard> {
  late final List<String> _black = List.of(widget.initialBlacklist);
  late final List<String> _white = List.of(widget.initialWhitelist);
  bool _showBlack = true;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final list = _showBlack ? _black : _white;

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
              AppInsets.sm,
            ),
            child: Text(
              t.webFilter,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: true,
                  label: Text(t.blacklist),
                  icon: const Icon(Icons.block_rounded, size: 18),
                ),
                ButtonSegment(
                  value: false,
                  label: Text(t.whitelist),
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                ),
              ],
              selected: {_showBlack},
              onSelectionChanged: (s) => setState(() => _showBlack = s.first),
            ),
          ),
          const SizedBox(height: AppInsets.sm),
          for (final site in list)
            ListTile(
              dense: true,
              leading: Icon(
                _showBlack
                    ? Icons.block_rounded
                    : Icons.check_circle_outline,
                color: _showBlack ? AppColors.danger : AppColors.success,
              ),
              title: Text(site),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => setState(() => list.remove(site)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppInsets.md),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: t.addSiteHint,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppInsets.radiusSm),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppInsets.md,
                        vertical: AppInsets.sm,
                      ),
                    ),
                    onSubmitted: (_) => _add(t),
                  ),
                ),
                const SizedBox(width: AppInsets.sm),
                FilledButton(
                  onPressed: () => _add(t),
                  child: const Icon(Icons.add_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _add(AppLocalizations t) {
    final site = _controller.text.trim();
    if (site.isEmpty) return;
    setState(() {
      (_showBlack ? _black : _white).add(site);
      _controller.clear();
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(t.siteAdded)));
  }
}
