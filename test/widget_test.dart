import 'package:flutter_test/flutter_test.dart';
import 'package:robita_life/app.dart';

void main() {
  testWidgets('App запускается и показывает нижнее меню', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RobitaLifeApp());
    await tester.pumpAndSettle();

    // Первый раздел — Сводка семьи, меню из 5 вкладок.
    expect(find.text('Сводка семьи'), findsWidgets);
    expect(find.text('Главная'), findsOneWidget);
    expect(find.text('Карта'), findsOneWidget);
    expect(find.text('Контроль'), findsOneWidget);
    expect(find.text('Планы'), findsOneWidget);
    expect(find.text('Чат'), findsOneWidget);
  });
}
