import 'package:ingetin_task_reminder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ingetin_task_reminder_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/pages/build_list_groceries_task.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/pages/build_list_important_task.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/pages/build_list_task.dart';
import 'package:ingetin_task_reminder_app/shared/widgets/drawer_task_widget.dart';
import 'package:ingetin_task_reminder_app/shared/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'build_list_planned_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toString();
    timeController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = context.read<HomeBloc>();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null) {
        String date = DateFormat.yMMMEd().format(picked);
        dateController.text = picked.toString();
        homeBloc.add(SelectDatepickerEvent(date: date));

        final TimeOfDay? timepicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (timepicked != null) {
          homeBloc.add(SelectTimepickerEvent(time: timepicked.format(context)));
          timeController.text = timepicked.format(context);
        }
      }
    }

    void settingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Please select category :",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Icons.task),
                          title: const Text('Task'),
                          onTap: () {
                            Navigator.pop(context);
                            categoryController.text = 'Task';
                            homeBloc.add(
                              const SelectCategoryEvent(category: 'Task'),
                            );
                          }),
                      ListTile(
                          leading: const Icon(Icons.shopping_basket),
                          title: const Text('Groceries'),
                          onTap: () {
                            Navigator.pop(context);
                            categoryController.text = 'Groceries';
                            homeBloc.add(
                              const SelectCategoryEvent(category: 'Groceries'),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      key: scaffoldKey,
      // resizeToAvoidBottomInset: true,
      // backgroundColor: akPrimaryBg,
      drawer: DrawerWidget(
        scaffoldKey: scaffoldKey,
        homeBloc: homeBloc,
      ),
      endDrawer: DrawerTaskWidget(
        scaffoldKey: scaffoldKey,
        homeBloc: homeBloc,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/beach.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 130,
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 0,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      bloc: homeBloc,
                      buildWhen: (previous, current) =>
                          current is! HomeActionState,
                      builder: (context, state) {
                        if (state is HomeLoadedTasks) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Day",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat("EEEEE, dd, MMM")
                                    .format(DateTime.now()),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        } else if (state is HomeLoadedImportantTasks) {
                          return const Text(
                            "Important task",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          );
                        } else if (state is HomeLoadedPlannedTasks) {
                          return const Text(
                            "Planned task",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          );
                        } else if (state is HomeLoadedGroceriesTasks) {
                          return const Text(
                            "Groceries",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0.1,
            right: 0.1,
            child: Container(
              width: double.infinity,
              height: Adaptive.h(80) - 30,
              padding: const EdgeInsets.only(
                top: 0,
                left: 16,
                right: 16,
                bottom: 0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocListener<AuthBloc, AuthState>(
                      listenWhen: ((previous, current) =>
                          current is AuthStateAction),
                      listener: (context, state) {
                        if (state is UnAuthenticated) {
                          // Navigate to the sign in screen when the user Signs Out
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                            (route) => false,
                          );
                        }
                      },
                      child: BlocConsumer<HomeBloc, HomeState>(
                        bloc: homeBloc,
                        listenWhen: (previous, current) =>
                            current is HomeActionState,
                        buildWhen: (previous, current) =>
                            current is! HomeActionState,
                        listener: (context, state) {
                          if (state is HomeAddTaskStateAction) {
                            taskController.text = '';
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Task succesfully added."),
                            ));
                          }
                        },
                        builder: (context, state) {
                          if (state is HomeLoadedTasks) {
                            return SafeArea(
                                child: SingleChildScrollView(
                              child: BuildListTask(
                                scaffoldKey: scaffoldKey,
                                taskController: taskController,
                                homeBloc: homeBloc,
                                user: user,
                                tasks: state.tasks,
                                tasksCompleted: state.tasksCompleted,
                              ),
                            ));
                          } else if (state is HomeLoadedImportantTasks) {
                            return SafeArea(
                                child: SingleChildScrollView(
                              child: BuildListImportantTask(
                                scaffoldKey: scaffoldKey,
                                taskController: taskController,
                                homeBloc: homeBloc,
                                user: user,
                                tasks: state.tasks,
                              ),
                            ));
                          } else if (state is HomeLoadedPlannedTasks) {
                            return SafeArea(
                                child: SingleChildScrollView(
                              child: BuildListPlannedTask(
                                scaffoldKey: scaffoldKey,
                                taskController: taskController,
                                homeBloc: homeBloc,
                                user: user,
                                tasks: state.tasks,
                              ),
                            ));
                          } else if (state is HomeLoadedGroceriesTasks) {
                            return SafeArea(
                                child: SingleChildScrollView(
                              child: BuildListGroceriesTask(
                                scaffoldKey: scaffoldKey,
                                taskController: taskController,
                                homeBloc: homeBloc,
                                user: user,
                                groceries: state.groceries,
                              ),
                            ));
                          } else if (state is HomeLoadingState) {
                            return buildLoading();
                          }

                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: const Center(
                              child: Text("Nothing to build"),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              left: 0.1,
              right: 0.1,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 0,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BlocBuilder<HomeBloc, HomeState>(
                            bloc: homeBloc,
                            buildWhen: (previous, current) =>
                                current is SelectDatepickerState,
                            builder: (context, state) {
                              if (state is SelectDatepickerState) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_view_week_outlined,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        state.date,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            bloc: homeBloc,
                            buildWhen: (previous, current) =>
                                current is SelectTimepickerState,
                            builder: (context, state) {
                              if (state is SelectTimepickerState) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock_clock,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        state.time,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: "Try typing like 'pay bill at 10pm'",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: InkWell(
                            onTap: () {
                              selectDate(context);
                            },
                            child: const Icon(
                              Icons.calendar_month,
                              size: 30,
                            ),
                          ),
                          icon: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              late IconData icon;
                              if (state is SelectCategoryState) {
                                if (state.category == 'Task') {
                                  icon = Icons.task;
                                } else {
                                  icon = Icons.shopping_basket;
                                }
                              } else {
                                categoryController.text = 'Task';
                                icon = Icons.task;
                              }
                              return InkWell(
                                onTap: () {
                                  settingModalBottomSheet(context);
                                },
                                child: Icon(
                                  icon,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              Task newTask = Task(
                                  uid: user.uid,
                                  task: taskController.text,
                                  completed: false,
                                  category: categoryController.text);
                              if (dateController.text != '') {
                                newTask.date = Timestamp.fromDate(
                                    DateTime.parse(dateController.text));
                              }
                              if (timeController.text != '') {
                                newTask.reminder = true;
                                newTask.date = Timestamp.fromDate(DateTime.parse(
                                    '${dateController.text.split(' ')[0]} ${timeController.text}'));
                                newTask.reminderAt = Timestamp.fromDate(
                                    DateTime.parse(
                                        '${dateController.text.split(' ')[0]} ${timeController.text}'));
                              }
                              homeBloc.add(
                                AddTaskEvent(
                                  task: newTask,
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

Widget buildLoading() => Center(
      child: Column(
        children: const [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Processing data..",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
