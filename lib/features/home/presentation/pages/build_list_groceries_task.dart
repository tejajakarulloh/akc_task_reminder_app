import 'package:akc_task_reminder_app/config/app_color.dart';
import 'package:akc_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:akc_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildListGroceriesTask extends StatelessWidget {
  const BuildListGroceriesTask({
    super.key,
    required this.scaffoldKey,
    required this.taskController,
    required this.homeBloc,
    required this.user,
    required this.groceries,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TextEditingController taskController;
  final HomeBloc homeBloc;
  final User user;
  final List<Task>? groceries;

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
              if (groceries!.isEmpty) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Center(
                    child: Text("No data .."),
                  ),
                );
              }
              return LimitedBox(
                maxHeight: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groceries!.length,
                  itemBuilder: (context, index) {
                    Task task = groceries![index];
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
              );
            }),
          ],
        ),
      ],
    );
  }
}
