part of 'overview_bloc.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object> get props => [];
}

class OverviewStarted extends OverviewEvent {
  const OverviewStarted();
}

class OverviewCompleteTodo extends OverviewEvent {
  final String id;
  const OverviewCompleteTodo({required this.id});
}

class OverviewUncompleteTodo extends OverviewEvent {
  final String id;
  const OverviewUncompleteTodo({required this.id});
}
