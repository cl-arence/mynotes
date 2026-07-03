import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:mynotes/views/auth/auth_screen.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: context.loc.verify_email,
      subtitle: context.loc.verify_email_view_prompt,
      icon: Icons.mark_email_read_outlined,
      children: [
        FilledButton.icon(
          onPressed: () {
            context.read<AuthBloc>().add(
              const AuthEventSendEmailVerification(),
            );
          },
          icon: const Icon(Icons.outgoing_mail),
          label: Text(context.loc.verify_email_send_email_verification),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventRefreshCurrentUser());
          },
          icon: const Icon(Icons.verified_outlined),
          label: Text(context.loc.verification_banner_check),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEventLogOut());
          },
          icon: const Icon(Icons.restart_alt),
          label: Text(context.loc.restart),
        ),
      ],
    );
  }
}
