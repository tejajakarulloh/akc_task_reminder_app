import 'package:akc_task_reminder_app/config/app_color.dart';
import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:akc_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_widget/flutter_expandable_widget.dart';

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
