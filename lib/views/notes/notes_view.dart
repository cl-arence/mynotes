import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/app_brand.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';
import 'package:mynotes/theme/app_theme.dart';
import 'package:mynotes/utilities/dialogs/logout_dialog.dart';
import 'package:mynotes/views/notes/notes_list_view.dart';
import 'package:mynotes/widgets/mindpad_icon.dart';
import 'package:mynotes/extensions/buildcontext/loc.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _searchController;
  String _query = '';

  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _searchController = TextEditingController()
      ..addListener(() {
        final nextQuery = _searchController.text.trim().toLowerCase();
        if (nextQuery == _query) {
          return;
        }
        setState(() {
          _query = nextQuery;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openNewNote() {
    Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
  }

  Iterable<CloudNote> _filterNotes(Iterable<CloudNote> notes) {
    if (_query.isEmpty) {
      return notes;
    }
    return notes.where((note) => note.text.toLowerCase().contains(_query));
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final currentUser = authState is AuthStateLoggedIn
        ? authState.user
        : AuthService.firebase().currentUser!;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return current is AuthStateLoggedIn &&
            (current.hasSentEmailVerification ||
                current.hasCheckedEmailVerification ||
                current.verificationException != null);
      },
      listener: (context, state) {
        if (state is! AuthStateLoggedIn) {
          return;
        }

        final message = switch (state) {
          AuthStateLoggedIn(verificationException: final exception)
              when exception != null =>
            context.loc.verification_banner_error,
          AuthStateLoggedIn(hasSentEmailVerification: true) =>
            context.loc.verification_banner_sent,
          AuthStateLoggedIn(
            hasCheckedEmailVerification: true,
            user: final user,
          ) =>
            user.isEmailVerified
                ? context.loc.verification_banner_verified
                : context.loc.verification_banner_still_pending,
          _ => null,
        };

        if (message == null) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId).getLength,
            builder: (context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final noteCount = snapshot.data ?? 0;
                final text = context.loc.notes_title(noteCount);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MindPadIcon(size: 30, showGlow: false),
                        const SizedBox(width: 10),
                        const Text(AppBrand.name),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.auto_awesome,
                          size: 18,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ],
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(176),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text(AppBrand.name);
              }
            },
          ),
          actions: [
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogoutDialog(context);
                    if (!context.mounted) {
                      return;
                    }
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(width: 12),
                        Text(context.loc.logout_button),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openNewNote,
          icon: const Icon(Icons.edit_note),
          label: Text(context.loc.notes_new_note),
        ),
        body: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  final visibleNotes = _filterNotes(
                    allNotes,
                  ).toList(growable: false);
                  final isSearching = _query.isNotEmpty;
                  return NotesListView(
                    notes: visibleNotes,
                    emptyTitle: isSearching
                        ? context.loc.notes_no_search_results
                        : context.loc.notes_empty_title,
                    emptyMessage: isSearching
                        ? context.loc.notes_no_search_results_body
                        : context.loc.notes_empty_body,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                        documentId: note.documentId,
                      );
                    },
                    onTap: (note) {
                      Navigator.of(
                        context,
                      ).pushNamed(createOrUpdateNoteRoute, arguments: note);
                    },
                    header: Column(
                      children: [
                        if (!currentUser.isEmailVerified &&
                            !currentUser.isAnonymous)
                          _VerificationBanner(user: currentUser),
                        _NotesSearchHeader(
                          controller: _searchController,
                          query: _query,
                          hintText: context.loc.notes_search_hint,
                          clearTooltip: context.loc.cancel,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              default:
                return Center(child: Text(context.loc.generic_error_prompt));
            }
          },
        ),
      ),
    );
  }
}

class _VerificationBanner extends StatelessWidget {
  final AuthUser user;

  const _VerificationBanner({required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final email = user.email;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.sunshine.withAlpha(175),
          border: Border.all(color: AppTheme.accent.withAlpha(120)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.mark_email_unread_outlined,
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.verification_banner_title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (email != null) ...[
                          const SizedBox(height: 3),
                          Text(
                            email,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppTheme.mutedInk,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                context.loc.verification_banner_body,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.ink.withAlpha(220),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerification(),
                      );
                    },
                    icon: const Icon(Icons.outgoing_mail),
                    label: Text(context.loc.verification_banner_resend),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const AuthEventRefreshCurrentUser(),
                      );
                    },
                    icon: const Icon(Icons.verified_outlined),
                    label: Text(context.loc.verification_banner_check),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotesSearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final String query;
  final String hintText;
  final String clearTooltip;

  const _NotesSearchHeader({
    required this.controller,
    required this.query,
    required this.hintText,
    required this.clearTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.sky.withAlpha(110),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: controller.clear,
                      tooltip: clearTooltip,
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
