import 'package:bloc/bloc.dart';
import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosApi api;
  StatsBloc({required this.api}) : super(const StatsState()) {
    on<InitialEvent>((event, emit) async {
      await emit.forEach(
        api.getTodos(),
        onData: (data) => StatsState(todos: data),
      );
    });
  }
}
