import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_manager/routes/generated_routes.dart';

import 'core/theme/app_theme.dart';
import 'features/tasks/presentation/bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'features/tasks/presentation/bloc/posts/posts_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TaskerApp());
}

class TaskerApp extends StatelessWidget {
  const TaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    log('Shared ${prefs.getString('LOGGED_IN_USER')}');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdateTaskBloc>()),
        BlocProvider(create: (_) => di.sl<AuthBloc>())
      ],
      child: MaterialApp(
        title: 'Tasks Manager',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
