import 'package:akc_task_reminder_app/config/app_color.dart';
import 'package:akc_task_reminder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:akc_task_reminder_app/features/auth/presentation/pages/sign_in.dart';
import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:akc_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:akc_task_reminder_app/shared/widgets/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_widget/flutter_expandable_widget.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    HomeBloc homeBloc = context.read<HomeBloc>();
    TextEditingController taskController = TextEditingController();

    print("woy build");
    return Scaffold(
      key: scaffoldKey,
      // resizeToAvoidBottomInset: true,
      // backgroundColor: akPrimaryBg,
      drawer: DrawerWidget(
        scaffoldKey: scaffoldKey,
      ),
      endDrawer: DrawerWidget(scaffoldKey: scaffoldKey),
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
                  const Text(
                    "My Day",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat("EEEEE, dd, MMM").format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
                          print("herebuild$state");
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
                          } else if (state is HomeLoadingState) {
                            return buildLoading();
                          }

                          print("disini 1 $state");
                          return Container(child: const Text("gk ada build"));
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
                  child: TextFormField(
                    controller: taskController,
                    decoration: InputDecoration(
                      // labelText: "Add a task",
                      hintText: "Add a task",
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      prefixIcon: InkWell(
                        onTap: () {
                          print('wa');
                        },
                        child: const Icon(Icons.calendar_month),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          homeBloc.add(
                            AddTaskEvent(
                              task: Task(
                                uid: user.uid,
                                task: taskController.text,
                                completed: false,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
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

class BuildListTask extends StatelessWidget {
  const BuildListTask({
    super.key,
    required this.scaffoldKey,
    required this.taskController,
    required this.homeBloc,
    required this.user,
    required this.tasks,
    required this.tasksCompleted,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController taskController;
  final HomeBloc homeBloc;
  final User user;
  final List<Task>? tasks;
  final List<Task>? tasksCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LimitedBox(
              maxHeight: 400,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasks!.length,
                itemBuilder: (context, index) {
                  Task task = tasks![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: akSoftWhite,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          hoverColor: akPrimaryBg,
                          checkColor: Colors.white,
                          activeColor: akPrimaryBg,
                          shape: const CircleBorder(),
                          value: task.completed,
                          onChanged: (value) {
                            task.completed = value!;
                            homeBloc.add(FlagTaskEvent(task: task));
                          },
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.task,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                task.category ?? 'Task',
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            task.important = (!task.important);
                            homeBloc.add(
                              FlagImportantTaskEvent(task: task),
                            );
                          },
                          child: task.important
                              ? Icon(
                                  Icons.star,
                                  color: akPrimaryBg,
                                )
                              : const Icon(
                                  Icons.star_border_outlined,
                                ),
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ExpandableWidget(
              padding: const EdgeInsets.all(0),
              childrenMargin: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: akPrimaryBg,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // trailing: const Icon(Icons.arrow_back),
              childrenPadding: const EdgeInsets.only(top: 20),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasksCompleted!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Task taskCompleted = tasksCompleted![index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: akSoftWhite,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            hoverColor: akPrimaryBg,
                            checkColor: Colors.white,
                            activeColor: akPrimaryBg,
                            shape: const CircleBorder(),
                            value: taskCompleted.completed,
                            onChanged: (value) {
                              taskCompleted.completed = value!;
                              homeBloc.add(FlagTaskEvent(task: taskCompleted));
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  taskCompleted.task,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  taskCompleted.category ?? 'Task',
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              taskCompleted.important =
                                  (!taskCompleted.important);
                              homeBloc.add(
                                FlagImportantTaskEvent(task: taskCompleted),
                              );
                            },
                            child: taskCompleted.important
                                ? Icon(
                                    Icons.star,
                                    color: akPrimaryBg,
                                  )
                                : const Icon(
                                    Icons.star_border_outlined,
                                  ),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 250,
            ),
          ],
        ),
      ],
    );
  }
}
