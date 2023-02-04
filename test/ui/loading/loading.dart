import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_meal_flutter/src/src.dart';

void main() {
  Future pumpMealItemCardWithPassingKey(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultLoading(
          key: Key(UIKeys.mealListLoading),
        ),
      ),
    );
  }

  Future pumpMealItemCardWithoutPassingKey(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DefaultLoading(),
      ),
    );
  }

  group('app_bar_test.dart', () {
    group('Given: No exceptions happen', () {
      testWidgets('When: DefaultLoading - Then: Render Widget',
          (WidgetTester tester) async {
        await pumpMealItemCardWithPassingKey(tester);

        await expectLater(find.byType(DefaultLoading), findsOneWidget);

        await expectLater(
          find.byKey(const Key(UIKeys.mealListLoading)),
          findsWidgets,
        );
      });

      testWidgets(
          'When: DefaultLoading - Then: Render Widget using default key',
          (WidgetTester tester) async {
        await pumpMealItemCardWithoutPassingKey(tester);

        await expectLater(find.byType(DefaultLoading), findsOneWidget);

        await expectLater(
          find.byKey(const Key(UIKeys.singleLoading)),
          findsOneWidget,
        );
      });
    });
  });
}
