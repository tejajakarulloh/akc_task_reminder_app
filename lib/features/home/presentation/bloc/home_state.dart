part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

abstract class HomeActionState extends HomeState {}

class HomeLoadedTasks extends HomeState {
  final String uid;
  final List<Task>? tasks;
  final List<Task>? tasksCompleted;
  const HomeLoadedTasks({
    required this.uid,
    this.tasks,
    this.tasksCompleted,
  });

  @override
  List<Object> get props => [uid, tasks!, tasksCompleted!];
}

class HomeLoadedImportantTasks extends HomeState {
  final String uid;
  final List<Task>? tasks;
  const HomeLoadedImportantTasks({
    required this.uid,
    this.tasks,
  });

  @override
  List<Object> get props => [uid, tasks!];
}

class HomeLoadedPlannedTasks extends HomeState {
  final String uid;
  final List<Task>? tasks;
  const HomeLoadedPlannedTasks({
    required this.uid,
    this.tasks,
  });

  @override
  List<Object> get props => [uid, tasks!];
}

class SelectDatepickerState extends HomeActionState {
  final String date;

  SelectDatepickerState({required this.date});

  @override
  List<Object> get props => [date];
}

class SelectCategoryState extends HomeActionState {
  final String category;

  SelectCategoryState({required this.category});

  @override
  List<Object> get props => [category];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingCompletedState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeErrorState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeAddTaskStateAction extends HomeActionState {
  @override
  List<Object?> get props => [];
}

class HomeFlagTaskStateAction extends HomeActionState {
  @override
  List<Object?> get props => [];
}
