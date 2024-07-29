part of 'overview_bloc.dart';

class OverviewState extends Equatable {
  final List<Todo> todos;
  const OverviewState({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
