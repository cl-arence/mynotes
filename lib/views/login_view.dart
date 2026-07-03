import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:mynotes/views/auth/auth_screen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

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
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _logIn() {
    final email = _email.text.trim();
    final password = _password.text;
    context.read<AuthBloc>().add(AuthEventLogIn(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_cannot_find_user,
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_wrong_credentials,
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, context.loc.login_error_auth_error);
          }
        }
      },
      child: AuthScreen(
        title: context.loc.login,
        subtitle: context.loc.login_view_prompt,
        icon: Icons.lock_outline,
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(
              labelText: context.loc.email_text_field_placeholder,
              prefixIcon: const Icon(Icons.alternate_email),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              labelText: context.loc.password_text_field_placeholder,
              prefixIcon: const Icon(Icons.lock_outline),
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _logIn(),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _logIn,
            icon: const Icon(Icons.login),
            label: Text(context.loc.login),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventShouldRegister());
            },
            child: Text(context.loc.login_view_not_registered_yet),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventForgotPassword());
            },
            child: Text(context.loc.login_view_forgot_password),
          ),
        ],
      ),
    );
  }
}
