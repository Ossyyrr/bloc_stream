part of 'stats_bloc.dart';

class StatsState extends Equatable {
  const StatsState({this.todos = const []});
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  int get getComplete => todos.where((element) => element.isCompleted).length;
  int get getUncomplete =>
      todos.where((element) => !element.isCompleted).length;
}
