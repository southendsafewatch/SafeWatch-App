import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  final Widget home;
  final Widget login;

  const AuthGate({
    super.key,
    required this.home,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0D0D),
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasData) {
          return home;
        } else {
          return login;
        }
      },
    );
  }
}
