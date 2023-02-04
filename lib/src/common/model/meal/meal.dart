import 'package:the_meal_flutter/src/src.dart';

class Meal extends BaseModel {
  final String? id;
  final String? name;
  final String? thumbnail;
  final String? category;
  final String? area;
  final String? instruction;
  final List<String>? tags;
  final List<String>? ingredients;
  final List<String>? measures;
  final List<String>? measureIngredient;
  final String? youtubeUrl;
  final String? source;

  Meal({
    this.id,
    this.name,
    this.thumbnail,
    this.category,
    this.area,
    this.instruction,
    this.tags,
    this.ingredients,
    this.measures,
    this.measureIngredient,
    this.youtubeUrl,
    this.source,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> tags = [];
    if (json['strTags'] != null) {
      tags = json['strTags'].toString().split(',');
    }

    List<String> ingredients = [];
    if (json.keys
        .where((key) => key.contains('strIngredient') == true)
        .isNotEmpty) {
      ingredients = json.keys
          .map<String>(
            (key) => key.contains('strIngredient') ? json[key] : '',
          )
          .where((value) => value.trim().isNotEmpty)
          .toList();
    }

    List<String> measures = [];
    if (json.keys
        .where((key) => key.contains('strMeasure') == true)
        .isNotEmpty) {
      measures = json.keys
          .map<String>((key) => key.contains('strMeasure') ? json[key] : '')
          .where((value) => value.trim().isNotEmpty)
          .toList();
    }

    List<String> measureIngredient = <String>[];
    for (int i = 0; i < measures.length; i++) {
      measureIngredient.add("${measures[i]} ${ingredients[i]}");
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      category: json['strCategory'],
      area: json['strArea'],
      instruction: json['strInstructions'],
      youtubeUrl: json['strYoutube'],
      source: json['strSource'],
      tags: tags,
      ingredients: ingredients,
      measures: measures,
      measureIngredient: measureIngredient,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};

    json['idMeal'] = id;
    json['strMeal'] = name;
    json['strMealThumb'] = thumbnail;
    json['strCategory'] = category;
    json['strArea'] = area;
    json['strInstructions'] = instruction;
    json['strYoutube'] = youtubeUrl;
    json['strSource'] = source;

    int indexIngredient = 1;
    for (String ingredient in ingredients ?? []) {
      indexIngredient++;
      json['strIngredient$indexIngredient'] = ingredient;
    }

    int indexMeasure = 1;
    for (String measure in measures ?? []) {
      indexMeasure++;
      json['strIngredient$indexMeasure'] = measure;
    }

    return json;
  }

  @override
  copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? category,
    String? area,
    String? instruction,
    List<String>? tags,
    List<String>? ingredients,
    List<String>? measures,
    List<String>? measureIngredient,
    String? youtubeUrl,
    String? source,
  }) =>
      Meal(
        id: id ?? this.id,
        name: name ?? this.name,
        thumbnail: thumbnail ?? this.thumbnail,
        category: category ?? this.category,
        area: area ?? this.area,
        instruction: instruction ?? this.instruction,
        tags: tags ?? this.tags,
        ingredients: ingredients ?? this.ingredients,
        measures: measures ?? this.measures,
        measureIngredient: measureIngredient ?? this.measureIngredient,
        youtubeUrl: youtubeUrl ?? this.youtubeUrl,
        source: source ?? this.source,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        thumbnail,
        category,
        area,
        instruction,
        tags,
        ingredients,
        measures,
        measureIngredient,
        youtubeUrl,
        source,
      ];
}
