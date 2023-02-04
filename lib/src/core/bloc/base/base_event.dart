import 'package:equatable/equatable.dart';

/// Base class for all events used in the blocs
abstract class BaseEvent<T> extends Equatable {
  final T? data;
  final DateTime? timestamp;

  BaseEvent({
    this.data,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
        data,
        timestamp,
      ];
}

/// Default event
///
/// This state must be called after the instantiation of the blocs
class InitializeEvent<T> extends BaseEvent<T> {
  InitializeEvent({
    DateTime? timestamp,
    T? data,
  }) : super(
          timestamp: timestamp,
          data: data,
        );

  @override
  String toString() {
    return 'InitializeEvent { timestamp: $timestamp, data: $data }';
  }
}

/// Main event to any action
///
/// If the bloc has multiple actions and needs more than one update state,
/// consider creating another micro update state on the corresponding blocs
class UpdateEvent<T> extends BaseEvent<T> {
  UpdateEvent({
    DateTime? timestamp,
    T? data,
  }) : super(
          timestamp: timestamp,
          data: data,
        );

  @override
  String toString() {
    return 'UpdateEvent { timestamp: $timestamp, data: $data }';
  }
}

/// Main event to refresh action
///
/// Mostly used in:
/// * Pulldown refresh
/// * Rebuild screen for rendering new data
/// * Infinite load on the list
///
/// If the bloc has multiple actions and needs more than one update state,
/// consider creating another micro update state on the corresponding blocs
class RefreshEvent<T> extends BaseEvent<T> {
  RefreshEvent({
    DateTime? timestamp,
    T? data,
  }) : super(
          timestamp: timestamp,
          data: data,
        );

  @override
  String toString() {
    return 'RefreshEvent { timestamp: $timestamp, data: $data }';
  }
}
