import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../mock/mock.dart';

void main() {
  List<MealActionCubit> cubits = <MealActionCubit>[];

  late MockBaseTheMealRepository mockBaseTheMealRepository;

  setUpAll(() {
    mockBaseTheMealRepository = MockBaseTheMealRepository();
  });

  tearDown(() {
    for (MealActionCubit bloc in cubits) {
      bloc.close();
    }
  });

  MealActionCubit buildSuccessState() {
    when(mockBaseTheMealRepository.getMealDetail(mealId: 'xxx1')).thenAnswer(
      (_) async => Future.value(
        Meal(
          id: 'xxx1',
          name: 'Item A',
          thumbnail: 'example.jpg',
        ),
      ),
    );

    MealActionCubit cubit =
        MealActionCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  MealActionCubit buildNotFoundState() {
    when(mockBaseTheMealRepository.getMealDetail(mealId: 'xxx1')).thenThrow(
      Exception(),
    );

    MealActionCubit cubit =
        MealActionCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  MealActionCubit buildErrorState() {
    when(mockBaseTheMealRepository.getMealDetail(mealId: 'xxx1'))
        .thenThrow(Exception());

    MealActionCubit cubit =
        MealActionCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  group('meal_action_cubit_test.dart', () {
    group('Given: No exceptions happen', () {
      blocTest<MealActionCubit, BaseState<Meal>>(
        'When: getMealDetail() & data found - Then: SuccessState()',
        build: () => buildSuccessState(),
        act: (cubit) => cubit.getMealDetail(mealId: 'xxx1'),
        expect: () => [isA<LoadingState>(), isA<SuccessState>()],
      );
    });

    group('Given: Exceptions happen', () {
      blocTest<MealActionCubit, BaseState<Meal>>(
        'When: getMealDetail() & data not found - Then: ErrorState()',
        build: () => buildNotFoundState(),
        act: (cubit) => cubit.getMealDetail(mealId: 'xxx1'),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      );
      blocTest<MealActionCubit, BaseState<Meal>>(
        'When: getMealDetail() - Then: ErrorState()',
        build: () => buildErrorState(),
        act: (cubit) => cubit.getMealDetail(mealId: 'xxx1'),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      );
    });
  });
}
