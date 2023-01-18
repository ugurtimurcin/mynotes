import 'package:flutter/material.dart';
import 'package:mynotes/consts/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import '../../utilities/show_log_out_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  @override
  void dispose() {
    _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    if (!mounted) return;
                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  height: 0,
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(newNoteRoute);
        },
        child: const Icon(Icons.edit_note_outlined),
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, streamSnapshot) {
                  switch (streamSnapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const CircularProgressIndicator();
                    default:
                      return const Text('data');
                  }
                },
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
