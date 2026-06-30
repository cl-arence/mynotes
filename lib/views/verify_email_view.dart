import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'A verification email has been sent to your email address. Please verify your email.',
            ),
            const Text(
              'If you have not received a verification email, press the button below.',
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
              },
              child: const Text('Send Email Verification'),
            ),
            TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
