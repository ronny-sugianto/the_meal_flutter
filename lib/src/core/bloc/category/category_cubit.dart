import 'package:the_meal_flutter/src/src.dart';

class CategoryCubit extends Cubit<BaseState<List<String>>> {
  final BaseTheMealRepository mealRepository;

  CategoryCubit({
    required this.mealRepository,
  }) : super(InitializedState());

  void getCategoryList() async {
    emit(LoadingState());

    List<String> categories = [];

    /// Get List Category
    try {
      categories = await mealRepository.getCategory();
      if (categories.isEmpty) return emit(EmptyState());
    } catch (e, s) {
      return emit(ErrorState(error: '$e', data: ['$s']));
    }

    emit(LoadedState(data: categories));
  }
}
