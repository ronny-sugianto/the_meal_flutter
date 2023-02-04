// Mocks generated by Mockito 5.3.2 from annotations
// in the_meal_flutter/src/core/repository/the_meal/base_the_meal_repository.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:the_meal_flutter/src/src.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [BaseTheMealRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseTheMealRepository extends _i1.Mock
    implements _i2.BaseTheMealRepository {
  @override
  _i3.Future<List<String>> getCategory() => (super.noSuchMethod(
        Invocation.method(
          #getCategory,
          [],
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
        returnValueForMissingStub: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);
  @override
  _i3.Future<List<_i2.Meal>> getMeal({String? category}) => (super.noSuchMethod(
        Invocation.method(
          #getMeal,
          [],
          {#category: category},
        ),
        returnValue: _i3.Future<List<_i2.Meal>>.value(<_i2.Meal>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i2.Meal>>.value(<_i2.Meal>[]),
      ) as _i3.Future<List<_i2.Meal>>);
  @override
  _i3.Future<_i2.Meal?> getMealDetail({required String? mealId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMealDetail,
          [],
          {#mealId: mealId},
        ),
        returnValue: _i3.Future<_i2.Meal?>.value(),
        returnValueForMissingStub: _i3.Future<_i2.Meal?>.value(),
      ) as _i3.Future<_i2.Meal?>);
}
