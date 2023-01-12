import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Column(
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
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;

            try {
              final userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              print(userCredential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('user not found');
              } else if (e.code == 'wrong-password') {
                print('wrong password');
              }
              print(e.code);
            }
          },
          child: const Text('Log In'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Not register yet? Register here!'),
        )
      ],
    );
  }
}
