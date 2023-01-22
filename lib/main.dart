import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/consts/routes.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/services/auth/firebase_auth_provider.dart';
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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
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
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
