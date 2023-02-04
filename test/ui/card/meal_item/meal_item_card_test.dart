import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../mock/mock.dart';

void main() {
  Future pumpMealItemCardWithThumbnail(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MealItemCard(
          index: 1,
          meal: Meal(
            id: 'xxx1',
            name: 'A',
            thumbnail:
                'https://file-examples.com/storage/feeb72b10363daaeba4c0c9/2017/10/file_example_JPG_100kB.jpg',
          ),
        ),
      ),
    );
  }

  Future pumpMealItemCardWithoutThumbnail(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MealItemCard(
          index: 1,
          meal: Meal(
            id: 'xxx1',
            name: 'A',
          ),
        ),
      ),
    );
  }

  group('meal_item_card_test.dart', () {
    group('Given: No exceptions happen', () {
      testWidgets('When: MealItemCard - Then: Render Widget',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await pumpMealItemCardWithThumbnail(tester);

          await expectLater(find.byType(MealItemCard), findsOneWidget);

          await expectLater(
            find.byKey(Key(UIKeys.mealItem(1))),
            findsOneWidget,
          );
          await expectLater(
            find.byKey(Key(UIKeys.mealItemThumbnailLoaded(1))),
            findsOneWidget,
          );
        });
      });

      testWidgets('When: MealItemCard - Then: Render Widget without Image',
          (WidgetTester tester) async {
        await pumpMealItemCardWithoutThumbnail(tester);

        await expectLater(find.byType(MealItemCard), findsOneWidget);

        await expectLater(
          find.byKey(Key(UIKeys.mealItem(1))),
          findsOneWidget,
        );
        await expectLater(
          find.byKey(Key(UIKeys.mealItemThumbnailNull(1))),
          findsOneWidget,
        );
      });
    });
  });
}
