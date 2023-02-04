import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_meal_flutter/src/src.dart';

void main() {
  Future pumpMealItemCardWithTitle(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: DefaultAppBar(
            title: 'Hello World!',
          ),
        ),
      ),
    );
  }

  Future pumpMealItemCardWithoutTitle(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: DefaultAppBar(),
        ),
      ),
    );
  }

  group('app_bar_test.dart', () {
    group('Given: No exceptions happen', () {
      testWidgets('When: DefaultAppBar - Then: Render Widget',
          (WidgetTester tester) async {
        await pumpMealItemCardWithTitle(tester);

        await expectLater(find.byType(DefaultAppBar), findsOneWidget);

        await expectLater(
          find.byKey(const Key(UIKeys.appBarBack)),
          findsOneWidget,
        );
        await expectLater(
          find.byKey(const Key(UIKeys.appBarTitle)),
          findsOneWidget,
        );
      });
    });

    testWidgets('When: DefaultAppBar - Then: Render Widget without title',
        (WidgetTester tester) async {
      await pumpMealItemCardWithoutTitle(tester);

      await expectLater(find.byType(DefaultAppBar), findsOneWidget);

      await expectLater(
        find.byKey(const Key(UIKeys.appBarBack)),
        findsOneWidget,
      );
      await expectLater(
        find.byKey(const Key(UIKeys.appBarTitle)),
        findsNothing,
      );
    });
  });
}
