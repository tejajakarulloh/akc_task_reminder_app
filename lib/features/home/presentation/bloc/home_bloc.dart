import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:akc_task_reminder_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl homeRepository;
  HomeBloc(this.homeRepository) : super(HomeLoadingState()) {
    on<HomeLoadedTasksEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> tasks = await homeRepository.retrieveTask();
      List<Task> tasksCompleted = await homeRepository.retrieveTaskCompleted();
      emit(HomeLoadedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
    });
    on<HomeLoadedImportantTasksEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> tasks = await homeRepository.retrieveImportantTask();
      emit(HomeLoadedImportantTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
      ));
    });
    on<HomeLoadedPlannedTasksEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> tasks = await homeRepository.retrievePlannedTask();
      emit(HomeLoadedPlannedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
      ));
    });
    on<HomeLoadedGroceriesTasksEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> groceries = await homeRepository.retrieveGroceriesTask();
      emit(HomeLoadedGroceriesTasks(
        uid: homeRepository.user.currentUser!.uid,
        groceries: groceries,
      ));
    });
    on<SelectDatepickerEvent>(((event, emit) async {
      emit(SelectDatepickerState(date: event.date));
    }));
    on<SelectCategoryEvent>(((event, emit) async {
      emit(SelectCategoryState(category: event.category));
    }));
    on<AddTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.saveTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      List<Task> tasksCompleted = await homeRepository.retrieveTaskCompleted();
      emit(HomeAddTaskStateAction());
      emit(HomeLoadedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
    }));
    on<FlagTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.flagTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      List<Task> tasksCompleted = await homeRepository.retrieveTaskCompleted();
      emit(HomeFlagTaskStateAction());
      emit(HomeLoadedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
    }));
    on<FlagImportantTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.flagImportantTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      List<Task> tasksCompleted = await homeRepository.retrieveTaskCompleted();
      emit(HomeFlagTaskStateAction());
      emit(HomeLoadedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
      print(event);
    }));
  }
}
