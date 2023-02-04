part of 'base_the_meal_repository.dart';

class TheMealRepository extends BaseTheMealRepository {
  final BaseApiClient apiClient;

  TheMealRepository({
    required this.apiClient,
  });

  @override
  Future<List<String>> getCategory() async {
    List<String> result = [];

    Response response = await apiClient.get(
      '/json/v1/1/list.php',
      queryParams: {
        'c': 'list',
      },
    );

    if (response.data != null && response.data['meals'] != null) {
      for (Map<String, dynamic> json in response.data['meals']) {
        result.add(json['strCategory']);
      }
    }

    return result;
  }

  @override
  Future<List<Meal>> getMeal({String? category}) async {
    List<Meal> result = [];

    Response response = await apiClient.get(
      '/json/v1/1/filter.php',
      queryParams: {
        'c': category,
      },
    );

    if (response.data != null && response.data['meals'] != null) {
      for (Map<String, dynamic> json in response.data['meals']) {
        result.add(Meal.fromJson(json));
      }
    }

    return result;
  }

  @override
  Future<Meal?> getMealDetail({required String mealId}) async {
    Meal? result;

    Response response = await apiClient.get(
      '/json/v1/1/lookup.php',
      queryParams: {
        'i': mealId,
      },
    );

    if (response.data != null && response.data['meals'] != null) {
      for (Map<String, dynamic> json in response.data['meals']) {
        result = Meal.fromJson(json);
      }
    }

    return result;
  }
}
