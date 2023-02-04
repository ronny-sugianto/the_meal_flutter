import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:the_meal_flutter/src/src.dart';

import '../../../mock/mock.dart';

void main() {
  late MockBaseApiClient apiClient;
  late BaseTheMealRepository theMealRepository;
  late String baseUrl;

  setUpAll(() {
    apiClient = MockBaseApiClient();
    baseUrl = 'https://example.com';

    theMealRepository = TheMealRepository(
      apiClient: apiClient,
    );
  });

  Map<String, dynamic> categoriesJson = {
    "meals": [
      {"strCategory": "Beef"},
      {"strCategory": "Breakfast"},
      {"strCategory": "Chicken"},
      {"strCategory": "Dessert"},
      {"strCategory": "Goat"},
      {"strCategory": "Lamb"},
      {"strCategory": "Miscellaneous"},
      {"strCategory": "Pasta"},
      {"strCategory": "Pork"},
      {"strCategory": "Seafood"},
      {"strCategory": "Side"},
      {"strCategory": "Starter"},
      {"strCategory": "Vegan"},
      {"strCategory": "Vegetarian"}
    ],
  };

  Map<String, dynamic> mealsJson = {
    "meals": [
      {
        "strMeal": "Breakfast Potatoes",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/1550441882.jpg",
        "idMeal": "52965"
      },
      {
        "strMeal": "English Breakfast",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/utxryw1511721587.jpg",
        "idMeal": "52895"
      },
      {
        "strMeal": "Fruit and Cream Cheese Breakfast Pastries",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/1543774956.jpg",
        "idMeal": "52957"
      },
      {
        "strMeal": "Full English Breakfast",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/sqrtwu1511721265.jpg",
        "idMeal": "52896"
      },
      {
        "strMeal": "Home-made Mandazi",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/thazgm1555350962.jpg",
        "idMeal": "52967"
      },
      {
        "strMeal": "Salmon Eggs Eggs Benedict",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/1550440197.jpg",
        "idMeal": "52962"
      },
      {
        "strMeal": "Smoked Haddock Kedgeree",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/1550441275.jpg",
        "idMeal": "52964"
      }
    ]
  };

  Map<String, dynamic> mealDetailJson = {
    "meals": [
      {
        "idMeal": "52965",
        "strMeal": "Breakfast Potatoes",
        "strDrinkAlternate": null,
        "strCategory": "Breakfast",
        "strArea": "Canadian",
        "strInstructions":
            "Before you do anything, freeze your bacon slices that way when you're ready to prep, it'll be so much easier to chop!\r\nWash the potatoes and cut medium dice into square pieces. To prevent any browning, place the already cut potatoes in a bowl filled with water.\r\nIn the meantime, heat 1-2 tablespoons of oil in a large skillet over medium-high heat. Tilt the skillet so the oil spreads evenly.\r\nOnce the oil is hot, drain the potatoes and add to the skillet. Season with salt, pepper, and Old Bay as needed.\r\nCook for 10 minutes, stirring the potatoes often, until brown. If needed, add a tablespoon more of oil.\r\nChop up the bacon and add to the potatoes. The bacon will start to render and the fat will begin to further cook the potatoes. Toss it up a bit! The bacon will take 5-6 minutes to crisp.\r\nOnce the bacon is cooked, reduce the heat to medium-low, add the minced garlic and toss. Season once more. Add dried or fresh parsley. Control heat as needed.\r\nLet the garlic cook until fragrant, about one minute.\r\nJust before serving, drizzle over the maple syrup and toss. Let that cook another minute, giving the potatoes a caramelized effect.\r\nServe in a warm bowl with a sunny side up egg!",
        "strMealThumb":
            "https://www.themealdb.com/images/media/meals/1550441882.jpg",
        "strTags": "Breakfast,Brunch,",
        "strYoutube": "https://www.youtube.com/watch?v=BoD0TIO9nE4",
        "strIngredient1": "Potatoes",
        "strIngredient2": "Olive Oil",
        "strIngredient3": "Bacon",
        "strIngredient4": "Garlic Clove",
        "strIngredient5": "Maple Syrup",
        "strIngredient6": "Parsley",
        "strIngredient7": "Salt",
        "strIngredient8": "Pepper",
        "strIngredient9": "Allspice",
        "strIngredient10": "",
        "strIngredient11": "",
        "strIngredient12": "",
        "strIngredient13": "",
        "strIngredient14": "",
        "strIngredient15": "",
        "strIngredient16": "",
        "strIngredient17": "",
        "strIngredient18": "",
        "strIngredient19": "",
        "strIngredient20": "",
        "strMeasure1": "3 Medium",
        "strMeasure2": "1 tbs",
        "strMeasure3": "2 strips",
        "strMeasure4": "Minced",
        "strMeasure5": "1 tbs",
        "strMeasure6": "Garnish",
        "strMeasure7": "Pinch",
        "strMeasure8": "Pinch",
        "strMeasure9": "To taste",
        "strMeasure10": " ",
        "strMeasure11": " ",
        "strMeasure12": " ",
        "strMeasure13": " ",
        "strMeasure14": " ",
        "strMeasure15": " ",
        "strMeasure16": " ",
        "strMeasure17": " ",
        "strMeasure18": " ",
        "strMeasure19": " ",
        "strMeasure20": " ",
        "strSource":
            "http://www.vodkaandbiscuits.com/2014/03/06/bangin-breakfast-potatoes/",
        "strImageSource": null,
        "strCreativeCommonsConfirmed": null,
        "dateModified": null
      }
    ]
  };

  group('the_meal_repository_test.dart', () {
    group('Given: No Exception', () {
      test('When: getCategory() - Then: List<String>', () async {
        /// Initial Variable
        late List<String>? result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/list.php',
          queryParams: {
            'c': 'list',
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: categoriesJson,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getCategory();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result != null, true);
      });
      test('When: getCategory() - Then: Empty', () async {
        /// Initial Variable
        late List<String>? result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/list.php',
          queryParams: {
            'c': 'list',
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: null,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getCategory();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result?.isEmpty, true);
      });
      test('When: getCategory() - Then: Error', () async {
        /// Initial Variable
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/list.php',
          queryParams: {
            'c': 'list',
          },
        )).thenThrow(Exception());

        /// Action
        try {
          await theMealRepository.getCategory();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, true);
      });
      test('When: getMeal({String? category}) - Then: List<Meal>', () async {
        /// Initial Variable
        late List<Meal> result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/filter.php',
          queryParams: {
            'c': null,
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: mealsJson,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getMeal();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result.isNotEmpty, true);
      });
      test('When: getMeal({String? category}) - Then: Empty', () async {
        /// Initial Variable
        late List<Meal> result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/filter.php',
          queryParams: {
            'c': null,
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: null,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getMeal();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result.isEmpty, true);
      });
      test('When: getMeal({String? category}) - Then: Error', () async {
        /// Initial Variable
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/filter.php',
          queryParams: {
            'c': null,
          },
        )).thenThrow(Exception());

        /// Action
        try {
          await theMealRepository.getMeal();
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, true);
      });
      test('When: getMealDetail({required String mealId}) - Then: Meal',
          () async {
        /// Initial Variable
        late Meal? result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/lookup.php',
          queryParams: {
            'i': 'xxx1',
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: mealDetailJson,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getMealDetail(mealId: 'xxx1');
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result != null, true);
      });
      test('When: getMealDetail({required String mealId}) - Then: Empty',
          () async {
        /// Initial Variable
        late Meal? result;
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/lookup.php',
          queryParams: {
            'i': 'xxx1',
          },
        )).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(
                path: '',
              ),
              data: null,
            ),
          ),
        );

        /// Action
        try {
          result = await theMealRepository.getMealDetail(mealId: 'xxx1');
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, false);
        expect(result == null, true);
      });
      test('When: getMealDetail({required String mealId}) - Then: Error',
          () async {
        /// Initial Variable
        bool isError = false;

        /// Stubbing
        when(apiClient.get(
          '$baseUrl/json/v1/1/lookup.php',
          queryParams: {
            'i': 'xxx1',
          },
        )).thenThrow(Exception());

        /// Action
        try {
          await theMealRepository.getMealDetail(mealId: 'xxx1');
        } catch (e) {
          isError = true;
        }

        /// Expect
        expect(isError, true);
      });
    });
  });
}
