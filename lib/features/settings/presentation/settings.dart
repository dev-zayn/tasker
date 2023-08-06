import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/auth/data/models/user_model.dart';
import 'package:task_manager/features/auth/domain/entities/user.dart';
import 'package:task_manager/injection_container.dart' as di;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    String jsonUser = prefs.getString('LOGGED_IN_USER') ?? '';
    UserEntity user = UserModel.fromJson(jsonDecode(jsonUser));
    return SafeArea(
      child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          children: [
            ListTile(
              title: Text('${user.title}'),
              subtitle: Text(user.email),
              leading: CircleAvatar(
                backgroundColor: secondaryColor,
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.white,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Logout'),
              trailing: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () async {
                await prefs.remove('LOGGED_IN_USER');
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
