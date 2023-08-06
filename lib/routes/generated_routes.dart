import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager/features/auth/presentation/pages/signup_page.dart';
import 'package:task_manager/features/tasks/presentation/pages/task_add_update_page.dart';
import 'package:task_manager/injection_container.dart' as di;

import '../landing/bloc/landing_bloc.dart';
import '../landing/presentation/landing.dart';

final LandingBloc landingBloc = LandingBloc();

SharedPreferences prefs = di.sl<SharedPreferences>();

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LandingBloc>.value(
            value: landingBloc,
            child: prefs.getString('LOGGED_IN_USER')?.isNotEmpty == true
                ? const LandingPage()
                : LoginPage(),
          ),
        );
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/addTask':
        return MaterialPageRoute(
            builder: (_) => const TaskAddUpdatePage(isUpdateTask: true));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
