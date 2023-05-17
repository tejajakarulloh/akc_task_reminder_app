import 'package:ingetin_task_reminder_app/config/app_color.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_widget/flutter_expandable_widget.dart';
import 'package:ingetin_task_reminder_app/shared/widgets/task_list_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        tasks!.isNotEmpty || tasksCompleted!.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LimitedBox(
                    maxHeight: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks!.length,
                      itemBuilder: (context, index) {
                        Task task = tasks![index];
                        return TaskListWidget(
                            scaffoldKey: scaffoldKey,
                            task: task,
                            homeBloc: homeBloc);
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
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
                          return TaskListWidget(
                              scaffoldKey: scaffoldKey,
                              task: taskCompleted,
                              homeBloc: homeBloc);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54.withOpacity(
                          0.45,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Lottie.asset('assets/lottie/my_day.json'),
                          ),
                          const Text(
                            "Focus on your day",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Get things done with My Day",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
