import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/user.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt_rounded, size: 17, color: secondaryColor),
            const SizedBox(width: 5),
            const Text(
              'By continuing you agree to our Terms of Use and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is MessageAuthState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          } else if (state is ErrorAuthState) {
            Navigator.of(context).pop();
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return const LoadingWidget();
          } else {
            return _buildForm(context);
          }
        },
      ),
    ));
  }

  _buildForm(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.task_alt_rounded, size: 100),
                  Text(
                    'Tasker',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Login to your Tasker account',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () => validateThenLogin(
                  context: context,
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/signup', (Route<dynamic> route) => false);
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void validateThenLogin(
    {required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey}) {
  final isValid = formKey.currentState!.validate();
  if (isValid) {
    final user = UserEntity(
      email: emailController.text,
      password: passwordController.text,
    );
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(userEntity: user));
  }
}
