import 'package:dio/dio.dart';
import 'package:the_meal_flutter/src/src.dart';

part 'the_meal_repository.dart';

abstract class BaseTheMealRepository {
  Future<List<String>> getCategory();
  Future<List<Meal>> getMeal({String? category});
  Future<Meal?> getMealDetail({required String mealId});
}
