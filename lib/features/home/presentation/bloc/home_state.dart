part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

abstract class HomeActionState extends HomeState {}

class HomeLoadedData extends HomeState {
  final String uid;
  final List<Task>? tasks;
  const HomeLoadedData({required this.uid, this.tasks});

  @override
  List<Object> get props => [uid, tasks!];
}

class HomeLoadingState extends HomeState {
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
