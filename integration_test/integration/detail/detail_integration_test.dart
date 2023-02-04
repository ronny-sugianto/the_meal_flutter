import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../test/mock/mock.dart';
import '../../helper/helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  final mealRepository = MockBaseTheMealRepository();

  Meal meal = Meal(
    id: 'xxx1',
    name: 'Item A',
    category: 'Breakfast',
    measureIngredient: ["1gr salt"],
    instruction: 'Hello World',
    thumbnail:
        'https://file-examples.com/storage/feeb72b10363daaeba4c0c9/2017/10/file_example_JPG_100kB.jpg',
  );

  Future<void> pumpApp(WidgetTester tester) async {
    await Helper().pumpApp(
      tester,
      blocProviders: [
        BlocProvider<CategoryCubit>.value(
          value: MockCategoryCubit()..getCategoryList(),
        ),
        BlocProvider<MealDataCubit>.value(
          value: MockMealDataCubit(),
        ),
        BlocProvider<MealActionCubit>.value(
          value: MockMealActionCubit(),
        )
      ],
      repositoryProviders: [
        RepositoryProvider<BaseTheMealRepository>.value(value: mealRepository),
      ],
    );
  }

  group('detail_integration_test.dart', () {
    group('Given: Normal flow', () {
      testWidgets(
          'When: User navigate to detail - Then: loaded successfully with data',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          // Stub function on CategoryCubit
          when(mealRepository.getCategory()).thenAnswer(
            (_) => Future.value(["Breakfast", "Food", "Burger"]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast")).thenAnswer(
            (_) => Future.value([meal]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMealDetail(mealId: "xxx1")).thenAnswer(
            (_) => Future.value(meal),
          );

          await pumpApp(tester);
          await tester.pumpAndSettle();

          // Home screen successfully loaded
          expect(find.byType(HomeScreen), findsOneWidget);

          // Tap Dropdown Category
          await tester.tap(find.byKey(const Key(UIKeys.categoryDropdown)));
          await tester.pump(const Duration(milliseconds: 250));

          await tester.tap(
            find.bySemanticsLabel(
              RegExp(
                '${UIKeys.categoryItem('Breakfast')}',
                caseSensitive: false,
              ),
            ),
          );

          await tester.pump(const Duration(milliseconds: 250));

          await tester.tap(find.byKey(Key(UIKeys.mealItem(0))));
          await tester.pump(const Duration(milliseconds: 2500));

          await expectLater(find.byType(DetailScreen), findsOneWidget);
          await tester.pump(const Duration(microseconds: 2500));

          // Screen
          expect(find.byKey(const Key(UIKeys.detailScreen)), findsOneWidget);

          // List View when Success
          expect(find.byKey(const Key(UIKeys.detailListView)), findsOneWidget);
          await tester.pump(const Duration(microseconds: 2500));

          await tester.tap(find.byKey(const Key(UIKeys.appBarBack)));
          await tester.pump(const Duration(milliseconds: 2500));

          await expectLater(find.byType(HomeScreen), findsOneWidget);
        });
      });
    });
  });
}
