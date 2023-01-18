import 'package:flutter/material.dart';
import 'package:mynotes/consts/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/create_update_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loginRoute:
            return PageTransition(
              settings: settings,
              child: const LoginView(),
              type: PageTransitionType.leftToRight,
            );
          case registerRoute:
            return PageTransition(
              settings: settings,
              child: const RegisterView(),
              type: PageTransitionType.leftToRight,
            );
          case notesRoute:
            return PageTransition(
              settings: settings,
              child: const NotesView(),
              type: PageTransitionType.leftToRight,
            );
          case verifyEmailRoute:
            return PageTransition(
              settings: settings,
              child: const VerifyEmailView(),
              type: PageTransitionType.leftToRight,
            );
          case createOrUpdateNoteRoute:
            return PageTransition(
              settings: settings,
              child: const CreateUpdateNoteView(),
              type: PageTransitionType.bottomToTop,
            );
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
