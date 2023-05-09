part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeLoadedTasksEvent extends HomeEvent {}

class HomeLoadedImportantTasksEvent extends HomeEvent {}

class HomeLoadedPlannedTasksEvent extends HomeEvent {}

class SelectDatepickerEvent extends HomeEvent {
  final String date;

  const SelectDatepickerEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class SelectCategoryEvent extends HomeEvent {
  final String category;

  const SelectCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

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

class FlagImportantTaskEvent extends HomeEvent {
  final Task task;

  const FlagImportantTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}
