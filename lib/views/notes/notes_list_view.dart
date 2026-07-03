import 'package:flutter/material.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/theme/app_theme.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';
import 'package:mynotes/widgets/mindpad_icon.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final Widget header;
  final String emptyTitle;
  final String emptyMessage;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.header,
    required this.emptyTitle,
    required this.emptyMessage,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final noteList = notes.toList(growable: false);

    if (noteList.isEmpty) {
      return Column(
        children: [
          header,
          Expanded(
            child: _EmptyNotesState(title: emptyTitle, message: emptyMessage),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      itemCount: noteList.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index == 0) {
          return header;
        }

        final note = noteList[index - 1];
        final title = _noteTitle(context, note);
        final subtitle = _noteSubtitle(note);
        final colorScheme = Theme.of(context).colorScheme;
        final accent =
            AppTheme.noteAccents[(index - 1) % AppTheme.noteAccents.length];

        return Card(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _cardColor(index),
              border: Border(left: BorderSide(color: accent, width: 7)),
            ),
            child: ListTile(
              onTap: () {
                onTap(note);
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: CircleAvatar(
                backgroundColor: accent.withAlpha(30),
                foregroundColor: accent,
                child: const Icon(Icons.sticky_note_2_outlined),
              ),
              title: Text(
                title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: subtitle == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
              trailing: IconButton(
                tooltip: context.loc.notes_delete_tooltip,
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: const Icon(Icons.delete_outline),
                color: colorScheme.error,
              ),
            ),
          ),
        );
      },
    );
  }

  String _noteTitle(BuildContext context, CloudNote note) {
    final lines = _noteLines(note);
    if (lines.isEmpty) {
      return context.loc.note;
    }
    return lines.first;
  }

  String? _noteSubtitle(CloudNote note) {
    final lines = _noteLines(note);
    if (lines.length < 2) {
      return null;
    }
    return lines.skip(1).join(' ');
  }

  List<String> _noteLines(CloudNote note) {
    return note.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
  }

  Color _cardColor(int index) {
    final colors = [
      AppTheme.surface,
      AppTheme.blush.withAlpha(90),
      AppTheme.mint.withAlpha(90),
      AppTheme.sunshine.withAlpha(110),
      AppTheme.lavender.withAlpha(95),
    ];
    return colors[(index - 1) % colors.length];
  }
}

class _EmptyNotesState extends StatelessWidget {
  final String title;
  final String message;

  const _EmptyNotesState({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MindPadIcon(size: 92),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha(176),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
