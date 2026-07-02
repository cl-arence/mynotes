import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionsBuilder: () => {context.loc.ok: null},
  );
}
