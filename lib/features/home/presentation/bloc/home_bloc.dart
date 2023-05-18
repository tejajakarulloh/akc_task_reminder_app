import 'package:alarm/alarm.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ingetin_task_reminder_app/shared/helpers/app_helper.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl homeRepository;
  HomeBloc(this.homeRepository) : super(HomeLoadingState()) {
    on<HomeLoadedAllTasksEvent>((event, emit) async {
      emit(HomeLoadingState());
      List<Task> tasks = await homeRepository.retrieveAllTask();
      List<Task> tasksCompleted =
          await homeRepository.retrieveAllTaskCompleted();
      emit(HomeLoadedAllTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
    });
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
    on<SelectTimepickerEvent>(((event, emit) async {
      emit(SelectTimepickerState(time: event.time));
    }));
    on<SelectCategoryEvent>(((event, emit) async {
      emit(SelectCategoryState(category: event.category));
    }));
    on<AddTaskEvent>(((event, emit) async {
      final storage =
          FlutterSecureStorage(aOptions: getAndroidOptionsStorage());
      emit(HomeLoadingState());
      if (event.task.reminder! == true) {
        int idAlarm = 0;
        if (await storage.containsKey(key: 'idAlarm')) {
          String? idPrev = await storage.read(key: 'idAlarm');
          idAlarm = int.tryParse(idPrev!)! + 1;
        } else {
          idAlarm += 1;
          storage.write(key: 'idAlarm', value: idAlarm.toString());
        }
        final alarmSettings = AlarmSettings(
          id: idAlarm,
          dateTime: timestampToDatetime(
              event.task.reminderAt!.millisecondsSinceEpoch),
          assetAudioPath: 'assets/audio/alarm.mp3',
          loopAudio: false,
          vibrate: true,
          fadeDuration: 3.0,
          notificationTitle: "Ingetin - Reminder Task",
          notificationBody: event.task.task,
          enableNotificationOnKill: true,
        );
        await Alarm.set(alarmSettings: alarmSettings);
      }

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
    }));
    on<SetSelectTaskEvent>(((event, emit) async {
      emit(SetSelectTaskState(task: event.task));
    }));

    on<UpdateTaskEvent>(((event, emit) async {
      emit(HomeLoadingState());
      await homeRepository.updateTask(event.task);
      List<Task> tasks = await homeRepository.retrieveTask();
      List<Task> tasksCompleted = await homeRepository.retrieveTaskCompleted();
      emit(HomeUpdateTaskStateAction());
      emit(HomeLoadedTasks(
        uid: homeRepository.user.currentUser!.uid,
        tasks: tasks,
        tasksCompleted: tasksCompleted,
      ));
    }));
  }
}
