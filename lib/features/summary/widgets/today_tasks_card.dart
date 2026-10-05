import 'package:flutter/material.dart';
import 'package:robita_life/l10n/app_localizations.dart';

import 'package:robita_life/core/theme/app_colors.dart';
import 'package:robita_life/core/theme/app_insets.dart';
import 'package:robita_life/widgets/glass_card.dart';
import '../model/task_item.dart';

/// Блок «Дела на сегодня»: чекбоксы, зачёркивание,
/// выполненные переносятся в архив внизу.
class TodayTasksCard extends StatefulWidget {
  const TodayTasksCard({super.key, required this.initialTasks});

  final List<TaskItem> initialTasks;

  @override
  State<TodayTasksCard> createState() => _TodayTasksCardState();
}

class _TodayTasksCardState extends State<TodayTasksCard> {
  late final List<TaskItem> _tasks = widget.initialTasks;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final open = _tasks.where((e) => !e.done).toList();
    final done = _tasks.where((e) => e.done).toList();

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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    t.todayTasks,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '${done.length}/${_tasks.length}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (open.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppInsets.md),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: AppInsets.sm),
                  Text(t.tasksAllDone),
                ],
              ),
            )
          else
            for (final task in open) _TaskTile(task: task, onChanged: _refresh),
          if (done.isNotEmpty) ...[
            const Divider(height: 1, indent: AppInsets.md),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppInsets.md,
                AppInsets.sm,
                AppInsets.md,
                AppInsets.xs,
              ),
              child: Text(
                '${t.tasksDone} • ${done.length}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            for (final task in done)
              _TaskTile(task: task, onChanged: _refresh),
            const SizedBox(height: AppInsets.sm),
          ] else
            const SizedBox(height: AppInsets.sm),
        ],
      ),
    );
  }

  void _refresh() => setState(() {});
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task, required this.onChanged});

  final TaskItem task;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    // Прозрачный Material для чернил уже даёт GlassCard выше по дереву.
    return CheckboxListTile(
      value: task.done,
      onChanged: (_) {
        task.done = !task.done;
        onChanged();
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppInsets.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppInsets.radiusSm),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.done ? TextDecoration.lineThrough : null,
          color: task.done
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
