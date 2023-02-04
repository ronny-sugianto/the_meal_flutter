import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_meal_flutter/src/src.dart';

void main() {
  group('message_cubit_test.dart', () {
    group('Given: Show Normal Snackbar', () {
      blocTest<MessageCubit, Message?>(
        'When: showSnackBar(isError: false) - Then: Message()',
        build: () => MessageCubit(),
        act: (cubit) => cubit.showSnackBar(
          message: 'Hello World!',
          timestamp: DateTime.now(),
        ),
        expect: () => [isA<Message>()],
      );
    });

    group('Given: Show Error Snackbar', () {
      blocTest<MessageCubit, Message?>(
        'When: showSnackBar(isError: true) - Then: Message()',
        build: () => MessageCubit(),
        act: (cubit) => cubit.showSnackBar(
          isError: true,
          message: 'Hello World!',
          timestamp: DateTime.now(),
        ),
        expect: () => [isA<Message>()],
      );
    });
  });
}
