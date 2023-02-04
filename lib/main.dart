import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
  );

  /// Initialize Clients
  BaseApiClient apiClient = ApiClient(
    alice: alice,
  );

  /// Initialize Repositories
  BaseTheMealRepository theMealRepository = TheMealRepository(
    apiClient: apiClient,
  );

  Bloc.observer = MainBlocObserver();

  runApp(
    InitializeApp(
      alice: alice,
      apiClient: apiClient,
      theMealRepository: theMealRepository,
    ),
  );
}
