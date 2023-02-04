import 'package:flutter/material.dart';
import 'package:the_meal_flutter/src/src.dart';

class Message extends BaseModel {
  final bool? isError;
  final String? message;
  final EdgeInsets? margin;
  final DateTime? timestamp;

  Message({
    this.isError,
    this.message,
    this.margin,
    this.timestamp,
  });

  @override
  List<Object?> get props => [isError, message, margin, timestamp];

  @override
  copyWith() {
    // TODO: no need implement copyWith
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: no need implement toJson
    throw UnimplementedError();
  }
}
