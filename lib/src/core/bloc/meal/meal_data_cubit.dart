import 'package:the_meal_flutter/src/src.dart';

class MealDataCubit extends Cubit<BaseState<List<Meal>>> {
  final BaseTheMealRepository mealRepository;
  MealDataCubit({
    required this.mealRepository,
  }) : super(InitializedState());

  void getMealList({
    String? category,
  }) async {
    emit(LoadingState());

    List<Meal> meals = [];

    /// Get Meal Detail by category
    try {
      meals = await mealRepository.getMeal(category: category);
      if (meals.isEmpty) return emit(EmptyState());
    } catch (e) {
      return emit(ErrorState(error: '$e'));
    }

    emit(LoadedState(data: meals));
  }
}
