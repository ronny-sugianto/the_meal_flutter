import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../mock/mock.dart';

void main() {
  List<MealDataCubit> cubits = <MealDataCubit>[];

  late MockBaseTheMealRepository mockBaseTheMealRepository;

  setUpAll(() {
    mockBaseTheMealRepository = MockBaseTheMealRepository();
  });

  tearDown(() {
    for (MealDataCubit bloc in cubits) {
      bloc.close();
    }
  });

  List<Meal> meals = [
    Meal(id: 'xxx1', name: 'Item A', thumbnail: 'example.jpg'),
  ];

  MealDataCubit buildLoadedState() {
    when(mockBaseTheMealRepository.getMeal()).thenAnswer(
      (_) async => Future.value(meals),
    );

    MealDataCubit cubit =
        MealDataCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  MealDataCubit buildEmptyState() {
    when(mockBaseTheMealRepository.getMeal()).thenAnswer(
      (_) async => Future.value([]),
    );

    MealDataCubit cubit =
        MealDataCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  MealDataCubit buildErrorState() {
    when(mockBaseTheMealRepository.getMeal()).thenThrow(Exception());

    MealDataCubit cubit =
        MealDataCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  group('meal_data_cubit_test.dart', () {
    group('Given: No exceptions happen', () {
      blocTest<MealDataCubit, BaseState<List<Meal>>>(
        'When: getMealList() - Then: LoadedState()',
        build: () => buildLoadedState(),
        act: (cubit) => cubit.getMealList(),
        expect: () => [isA<LoadingState>(), isA<LoadedState>()],
      );
      blocTest<MealDataCubit, BaseState<List<Meal>>>(
        'When: getMealList() - Then: EmptyState()',
        build: () => buildEmptyState(),
        act: (cubit) => cubit.getMealList(),
        expect: () => [isA<LoadingState>(), isA<EmptyState>()],
      );
    });

    group('Given: Exceptions happen', () {
      blocTest<MealDataCubit, BaseState<List<Meal>>>(
        'When: getMealList() - Then: ErrorState()',
        build: () => buildErrorState(),
        act: (cubit) => cubit.getMealList(),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      );
    });
  });
}
