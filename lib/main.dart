import 'package:akc_task_reminder_app/app.dart';
import 'package:akc_task_reminder_app/app_bloc_observer.dart';
import 'package:akc_task_reminder_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:akc_task_reminder_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:akc_task_reminder_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) =>
                HomeBloc(HomeRepositoryImpl())..add(HomeLoadedTasksEvent()),
          ),
        ],
        child: const App(),
      ),
    );
  }
}
