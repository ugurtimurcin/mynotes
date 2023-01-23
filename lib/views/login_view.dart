import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mynotes/consts/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  void handlePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.mail_outlined),
            ),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  handlePasswordVisibility();
                },
                icon: Icon(
                  _hidePassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            autocorrect: false,
            obscureText: _hidePassword,
            enableSuggestions: false,
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateLoggedOut) {
                if (state.exception is UserNotFoundAuthException) {
                  await showErrorDialog(context, 'User not found');
                } else if (state.exception is WrongPasswordAuthException) {
                  await showErrorDialog(context, 'Wrong credentials');
                } else if (state.exception is InvalidEmailAuthException) {
                  await showErrorDialog(context, 'Invalid email');
                } else if (state.exception is GenericAuthException) {
                  await showErrorDialog(context, 'Authentication error');
                }
              }
            },
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                context.read<AuthBloc>().add(
                      AuthEventLogIn(email, password),
                    );
              },
              child: const Text('Log In'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not register yet? Register here!'),
          )
        ],
      ),
    );
  }
}
