import 'package:akc_task_reminder_app/config/app_color.dart';
import 'package:akc_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeBloc homeBloc;
  const DrawerWidget(
      {super.key, required this.scaffoldKey, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      backgroundColor: akSoftWhite,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                      },
                      child: const Icon(Icons.menu)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ClipOval(
                    child: Icon(
                      Icons.people,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: InkWell(
                      onTap: () {
                        print('wa');
                      },
                      child: const Icon(Icons.search)),
                  contentPadding: const EdgeInsets.all(0),
                ),
              ),
            ),
            _drawerItem(
                icon: Icons.calendar_today,
                text: 'My Day',
                onTap: () => homeBloc.add(HomeLoadedTasksEvent())),
            _drawerItem(
                icon: Icons.star_border_purple500,
                text: 'Important',
                onTap: () => homeBloc.add(HomeLoadedImportantTasksEvent())),
            _drawerItem(
                icon: Icons.calendar_view_week_outlined,
                text: 'Planned',
                onTap: () => print('Tap Recent menu')),
            _drawerItem(
                icon: Icons.task_alt_outlined,
                text: 'Task',
                onTap: () => print('Tap Trash menu')),
            const Divider(height: 25, thickness: 1),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(left: 20, top: 0, bottom: 0, right: 0),
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
