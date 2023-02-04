import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_meal_flutter/src/src.dart';

/// Cubits
class MockMessageCubit extends MockCubit<Message?> implements MessageCubit {}

class MockCategoryCubit extends MockCubit<BaseState<List<String>>>
    implements CategoryCubit {}

class MockMealDataCubit extends MockCubit<BaseState<List<Meal>>>
    implements MealDataCubit {}

class MockMealActionCubit extends MockCubit<BaseState<Meal>>
    implements MealActionCubit {}

/// Fakes
class FakeBaseState extends Fake implements BaseState {}
