import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_stream/presentation/stats/bloc/stats_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'stats_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodosApi>()])
void main() {
  final todo = Todo(
    title: 'Title',
    description: 'Description',
    isCompleted: true,
    id: '111',
  );

  late MockTodosApi api;
  late StatsBloc bloc;

  setUp(
    () {
      api = MockTodosApi();
      bloc = StatsBloc(api: api);
    },
  );

  group(
    'StatsBloc',
    () {
      group(
        'Initial state',
        () {
          test(
            'bloc return initial state',
            () {
              final instance = StatsBloc(api: api);
              expect(instance.state, equals(const StatsState()));
            },
          );
        },
      );

      group(
        'InitialEvent',
        () {
          blocTest<StatsBloc, StatsState>(
            'emits [StatsBloc] when InitialEvent is added.',
            setUp: () {
              when(api.getTodos()).thenAnswer(
                (_) => Stream.value([todo]),
              );
            },
            build: () => bloc,
            act: (bloc) => bloc.add(const InitialEvent()),
            expect: () => <StatsState>[
              StatsState(todos: [todo])
            ],
            verify: (bloc) => verify(api.getTodos()),
          );
        },
      );
    },
  );
}
