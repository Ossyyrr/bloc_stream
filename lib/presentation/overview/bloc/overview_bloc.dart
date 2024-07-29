import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_stream/data/data_source/todos_api.dart';
import 'package:bloc_stream/domain/model/todo.dart';
import 'package:equatable/equatable.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final TodosApi api;
  OverviewBloc({required this.api}) : super(const OverviewState()) {
    on<OverviewStarted>(_onStarted);
    on<OverviewCompleteTodo>(_onComplete);
    on<OverviewUncompleteTodo>(_onUncomplete);
  }

  Future<void> _onStarted(
      OverviewStarted event, Emitter<OverviewState> emit) async {
    await emit.forEach(
      api.getTodos(),
      onData: (data) => OverviewState(todos: data),
    );
  }

  Future<void> _onComplete(
      OverviewCompleteTodo event, Emitter<OverviewState> emit) async {
    final currentTodo = state.todos.firstWhere(
      (element) => element.id == event.id,
    );
    await api.saveTodo(currentTodo.copyWith(isCompleted: true));
  }

  Future<void> _onUncomplete(
      OverviewUncompleteTodo event, Emitter<OverviewState> emit) async {
    final currentTodo = state.todos.firstWhere(
      (element) => element.id == event.id,
    );
    await api.saveTodo(currentTodo.copyWith(isCompleted: false));
  }
}
