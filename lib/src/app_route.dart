import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

/// Application router
///
/// This class handle named routing for entire application.
class AppRouter {
  /// Delegates for screen routing
  Route onGenerateRoute(RouteSettings routeSettings) {
    final ScreenArgument? args = routeSettings.arguments != null
        ? routeSettings.arguments as ScreenArgument
        : null;

    switch (routeSettings.name) {
      case RouteName.homeScreen:
        return _pageRoute(
          routeSettings.name!,
          args: args,
          screen: const HomeScreen(),
        );
      case RouteName.detailScreen:
        return _pageRoute(
          routeSettings.name!,
          args: args,
          screen: const DetailScreen(),
        );
      default:
        return _pageRoute(
          RouteName.notFoundScreen,
          screen: const NotFoundScreen(),
        );
    }
  }

  MaterialPageRoute _pageRoute(
    String screenName, {
    ScreenArgument? args,
    required Widget screen,
  }) =>
      MaterialPageRoute(
        settings: RouteSettings(
          name: screenName,
          arguments: args?.data,
        ),
        builder: (_) => screen,
      );
}
