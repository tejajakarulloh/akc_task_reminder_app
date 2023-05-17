import 'package:ingetin_task_reminder_app/config/app_color.dart';
import 'package:ingetin_task_reminder_app/features/home/data/models/task_model.dart';
import 'package:ingetin_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/app_helper.dart';

class DrawerTaskWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeBloc homeBloc;
  const DrawerTaskWidget(
      {super.key, required this.scaffoldKey, required this.homeBloc});

  @override
  State<DrawerTaskWidget> createState() => _DrawerTaskWidgetState();
}

class _DrawerTaskWidgetState extends State<DrawerTaskWidget> {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: akSoftWhite,
      child: SafeArea(
        child: BlocConsumer<HomeBloc, HomeState>(
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is HomeLoadedTasks) {
              widget.scaffoldKey.currentState!.closeEndDrawer();
            }

            if (state is HomeUpdateTaskStateAction) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Task succesfully updated."),
              ));
            }
          },
          builder: (context, state) {
            if (state is SetSelectTaskState) {
              Task task = state.task;

              taskController.text = task.task;
              return ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.scaffoldKey.currentState!
                                    .closeEndDrawer();
                              },
                              child: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: InkWell(
                          onTap: () {
                            task.important = (!task.important);
                            widget.homeBloc.add(
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
                      ),
                    ],
                  ),
                  Container(
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
                            widget.homeBloc.add(FlagTaskEvent(task: task));
                          },
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: taskController,
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            task.task = taskController.text;
                            widget.homeBloc.add(
                              UpdateTaskEvent(task: task),
                            );
                          },
                          child: const Icon(Icons.save),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 25, thickness: 1),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                task.category == 'Task'
                                    ? Icons.task
                                    : Icons.shopping_basket,
                                size: 25,
                                color: akPrimaryBg,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                task.category ?? 'Task',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 25,
                                color: akPrimaryBg,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                timestampToDate(task.date!.toDate()),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
