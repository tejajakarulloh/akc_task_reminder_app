import 'package:flutter/material.dart';
import 'package:ingetin_task_reminder_app/config/app_color.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:ingetin_task_reminder_app/shared/helpers/app_helper.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.scaffoldKey,
    required this.task,
    required this.homeBloc,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Task task;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeBloc.add(SetSelectTaskEvent(task: task));
        scaffoldKey.currentState!.openEndDrawer();
      },
      child: Container(
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
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        task.category == 'Task'
                            ? Icons.task
                            : Icons.shopping_basket,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        task.category ?? 'Task',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.calendar_today,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        timestampToDate(task.date!.toDate()),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
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
      ),
    );
  }
}
