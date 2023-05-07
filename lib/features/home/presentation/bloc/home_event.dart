part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeLoadedDataEvent extends HomeEvent {}

class AddTaskEvent extends HomeEvent {
  final Task task;

  const AddTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class FlagTaskEvent extends HomeEvent {
  final Task task;

  const FlagTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}
