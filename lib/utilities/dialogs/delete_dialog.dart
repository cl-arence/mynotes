import 'package:flutter/material.dart';
import 'generic_dialog.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: context.loc.delete,
    content: context.loc.delete_note_prompt,
    optionsBuilder: () => {context.loc.cancel: false, context.loc.yes: true},
  ).then((value) => value ?? false);
}
