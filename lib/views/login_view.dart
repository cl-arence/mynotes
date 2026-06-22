import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            enableSuggestions: false,
          ),

          TextField(
            controller: _password,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),

          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified == true) {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'User not found.');
              } on WrongPasswordAuthException {
                await showErrorDialog(context, 'Wrong password.');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication error.');
              }
            },
            child: const Text('Login'),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
