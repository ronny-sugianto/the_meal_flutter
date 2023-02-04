import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../mock/mock.dart';

void main() {
  List<CategoryCubit> cubits = <CategoryCubit>[];

  late MockBaseTheMealRepository mockBaseTheMealRepository;

  setUpAll(() {
    mockBaseTheMealRepository = MockBaseTheMealRepository();
  });

  tearDown(() {
    for (CategoryCubit bloc in cubits) {
      bloc.close();
    }
  });

  CategoryCubit buildLoadedState() {
    when(mockBaseTheMealRepository.getCategory()).thenAnswer(
      (_) async => Future.value(["A", "B", "C"]),
    );

    CategoryCubit cubit =
        CategoryCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  CategoryCubit buildEmptyState() {
    when(mockBaseTheMealRepository.getCategory()).thenAnswer(
      (_) async => Future.value([]),
    );

    CategoryCubit cubit =
        CategoryCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  CategoryCubit buildErrorState() {
    when(mockBaseTheMealRepository.getCategory()).thenThrow(Exception());

    CategoryCubit cubit =
        CategoryCubit(mealRepository: mockBaseTheMealRepository);

    cubits.add(cubit);
    return cubit;
  }

  group('category_cubit_test.dart', () {
    group('Given: No exceptions happen', () {
      blocTest<CategoryCubit, BaseState<List<String>>>(
        'When: getCategoryList() - Then: LoadedState()',
        build: () => buildLoadedState(),
        act: (cubit) => cubit.getCategoryList(),
        expect: () => [isA<LoadingState>(), isA<LoadedState>()],
      );
      blocTest<CategoryCubit, BaseState<List<String>>>(
        'When: getCategoryList() - Then: EmptyState()',
        build: () => buildEmptyState(),
        act: (cubit) => cubit.getCategoryList(),
        expect: () => [isA<LoadingState>(), isA<EmptyState>()],
      );
    });

    group('Given: Exceptions happen', () {
      blocTest<CategoryCubit, BaseState<List<String>>>(
        'When: getCategoryList() - Then: ErrorState()',
        build: () => buildErrorState(),
        act: (cubit) => cubit.getCategoryList(),
        expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      );
    });
  });
}
