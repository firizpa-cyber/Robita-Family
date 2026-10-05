import 'package:flutter/material.dart';

import '../model/family_member.dart';
import '../model/task_item.dart';

/// Моковые данные Сводки. Заменим на API на следующих этапах.
abstract final class SummaryMock {
  static const members = <FamilyMember>[
    FamilyMember(
      name: 'Папа',
      role: 'Родитель',
      avatarColor: Color(0xFF4C6FFF),
      battery: 0.78,
      isOnline: true,
    ),
    FamilyMember(
      name: 'Мама',
      role: 'Родитель',
      avatarColor: Color(0xFFFF6FA5),
      battery: 0.45,
      isOnline: true,
    ),
    FamilyMember(
      name: 'Али',
      role: 'Сын',
      avatarColor: Color(0xFF22B47E),
      battery: 0.18,
      lastSeenMinutes: 10,
    ),
    FamilyMember(
      name: 'Малика',
      role: 'Дочь',
      avatarColor: Color(0xFF7C4DFF),
      battery: 0.92,
      isOnline: true,
    ),
  ];

  static List<TaskItem> todayTasks() => [
    TaskItem(title: 'Забрать Малику из школы'),
    TaskItem(title: 'Купить продукты'),
    TaskItem(title: 'Али: математика, стр. 42'),
    TaskItem(title: 'Оплатить кружок'),
  ];
}
