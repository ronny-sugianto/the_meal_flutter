import 'package:the_meal_flutter/src/src.dart';

/// Base class for all screen argument models
class ScreenArgument extends BaseModel {
  /// Model for specific screen argument, please consider using its own class
  /// argument to avoid dynamic type. Because flutter disable mirroring, please
  /// be careful when casting the data property on each screens
  final Object? data;

  /// Indicate current [RouteName]
  ///
  /// Some implementation need to know current route to determine certain behaviour
  final String? currentRoute;

  ScreenArgument({
    this.data,
    this.currentRoute,
  });

  fromJson(Map<String, dynamic> json) => ScreenArgument(
        data: json['data'],
        currentRoute: json['currentRoute'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data,
        'currentRoute': currentRoute,
      };

  @override
  copyWith({
    Object? data,
    String? currentRoute,
  }) =>
      ScreenArgument(
        data: data ?? this.data,
        currentRoute: currentRoute ?? this.currentRoute,
      );

  @override
  List<Object?> get props => [data, currentRoute];
}
