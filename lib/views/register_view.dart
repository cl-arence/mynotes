import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: const Text('Register')),
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
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'The password provided is too weak.',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'The account already exists for that email.',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'The email is invalid.');
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to register.');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
