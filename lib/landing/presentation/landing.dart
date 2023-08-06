import 'dart:developer';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/tasks/presentation/pages/task_add_update_page.dart';
import 'package:task_manager/features/tasks/presentation/pages/tasks_page.dart';
import 'package:task_manager/landing/bloc/landing_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../features/settings/presentation/settings.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        final List<Widget> widgetOptions = <Widget>[
          const TasksPage(),
          const TaskAddUpdatePage(isUpdateTask: false),
          const SettingPage(),
        ];
        return Scaffold(
          body: widgetOptions.elementAt(state.index),
          bottomNavigationBar: FloatingNavbar(
            onTap: (int val) {
              log('val: $val');
              BlocProvider.of<LandingBloc>(context)
                  .add(TabChangedEvent(index: val));
            },
            currentIndex: state.index,
            backgroundColor: primaryColor,
            selectedItemColor: secondaryColor,
            elevation: 0,
            selectedBackgroundColor: Colors.white,
            items: [
              FloatingNavbarItem(
                  icon: Icons.task_alt_outlined, title: 'MY Tasks'),
              FloatingNavbarItem(
                  icon: Icons.add_task_outlined, title: 'Add Task'),
              FloatingNavbarItem(
                  icon: Icons.settings_outlined, title: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
