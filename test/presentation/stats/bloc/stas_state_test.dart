import 'package:bloc_stream/domain/model/todo.dart';
import 'package:bloc_stream/presentation/stats/bloc/stats_bloc.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
   final todo = Todo(
    title: 'Title',
    description: 'Description',
    isCompleted: true,
    id: '111',
  );

  group(
    'StatsState',
    () {
      group(
        'Creation',
        () {
          test(
            'can be instantiated',
            () {
              expect(const StatsState(), isNotNull);
            },
          );
        },
      );

      group(
        'Comparison',
        () {
          test(
            'states can be compared',
            () {
              expect(const StatsState(), equals(const StatsState()));
            },
          );
        },
      );

      group(
        'getComplete',
        () {
          test(
            'return the number of completed todos',
            () {
              final instance = StatsState(todos: [todo]);
              expect(instance.getComplete, equals(1));
            },
          );
        },
      );

      group(
        'getUncomplete',
        () {
          test(
            'return the number of uncompleted todos',
            () {
              final instance = StatsState(todos: [todo]);
              expect(instance.getUncomplete, equals(0));
            },
          );
        },
      );
    },
  );
}