import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  Future<void> _setRole(String role) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "role": role,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Role")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _setRole("parent");
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("Parent"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _setRole("teen");
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("Teen"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _setRole("volunteer");
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("Volunteer"),
            ),
          ],
        ),
      ),
    );
  }
}
