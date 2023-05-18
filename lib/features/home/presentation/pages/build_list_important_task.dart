import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ingetin_task_reminder_app/shared/widgets/task_list_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuildListImportantTask extends StatelessWidget {
  const BuildListImportantTask({
    super.key,
    required this.scaffoldKey,
    required this.taskController,
    required this.homeBloc,
    required this.user,
    required this.tasks,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController taskController;
  final HomeBloc homeBloc;
  final User user;
  final List<Task>? tasks;

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
            Builder(builder: (context) {
              if (tasks!.isEmpty) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: Text("No data .."),
                  ),
                );
              }
              return LimitedBox(
                maxHeight: 70.h,
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
              );
            }),
          ],
        ),
      ],
    );
  }
}
