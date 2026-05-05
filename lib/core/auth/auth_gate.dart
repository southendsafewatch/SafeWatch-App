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
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // USER LOGGED IN
        if (snap.hasData) {
          return home;
        }

        // USER LOGGED OUT
        return login;
      },
    );
  }
}
