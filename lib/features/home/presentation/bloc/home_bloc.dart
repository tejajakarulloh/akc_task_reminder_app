import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:akc_task_reminder_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl homeRepository;
  HomeBloc(this.homeRepository) : super(HomeLoadingState()) {
    on<HomeLoadedDataEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> tasks = await homeRepository.retrieveTask();
      emit(HomeLoadedData(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
      ));
    });
    on<AddTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.saveTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      emit(HomeAddTaskStateAction());
      emit(HomeLoadedData(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
      ));
    }));
    on<FlagTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.flagTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      emit(HomeFlagTaskStateAction());
      emit(HomeLoadedData(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
      ));
    }));
  }
}
