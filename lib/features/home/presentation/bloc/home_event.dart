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

class HomeLoadedGroceriesTasksEvent extends HomeEvent {}

class SelectDatepickerEvent extends HomeEvent {
  final String date;

  const SelectDatepickerEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class SelectTimepickerEvent extends HomeEvent {
  final String time;

  const SelectTimepickerEvent({required this.time});

  @override
  List<Object> get props => [time];
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

class SetSelectTaskEvent extends HomeEvent {
  final Task task;

  const SetSelectTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends HomeEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}
