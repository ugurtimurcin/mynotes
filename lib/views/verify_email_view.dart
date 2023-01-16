import 'package:flutter/material.dart';
import 'package:mynotes/consts/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: const [
                Text(
                    'We\'ve already sent you an email verification. Open it to verify your account.'),
                Divider(
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 0,
                  color: Color.fromARGB(255, 194, 216, 226),
                ),
                Text(
                    'If you haven\'t received a verification email, press the button below.'),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if (!mounted) return;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
