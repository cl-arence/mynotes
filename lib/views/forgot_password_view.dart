import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/password_reset_email_sent_dialog.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:mynotes/views/auth/auth_screen.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    final email = _controller.text.trim();
    context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetEmailSentDialog(context);
            if (!context.mounted) {
              return;
            }
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              context.loc.forgot_password_view_generic_error,
            );
          }
        }
      },
      child: AuthScreen(
        title: context.loc.forgot_password,
        subtitle: context.loc.forgot_password_view_prompt,
        icon: Icons.mark_email_unread_outlined,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: context.loc.email_text_field_placeholder,
              prefixIcon: const Icon(Icons.alternate_email),
            ),
            autocorrect: false,
            enableSuggestions: false,
            autofillHints: const [AutofillHints.email],
            onSubmitted: (_) => _sendResetLink(),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _sendResetLink,
            icon: const Icon(Icons.send_outlined),
            label: Text(context.loc.forgot_password_view_send_me_link),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: Text(context.loc.forgot_password_view_back_to_login),
          ),
        ],
      ),
    );
  }
}
