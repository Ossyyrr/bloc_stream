part of 'overview_bloc.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object> get props => [];
}

class OverviewStarted extends OverviewEvent {
  const OverviewStarted();
}
