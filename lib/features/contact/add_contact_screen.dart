import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final relationCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Add Contact"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _input("Name", nameCtrl),
            const SizedBox(height: 16),
            _input("Phone Number", phoneCtrl),
            const SizedBox(height: 16),
            _input("Relation (optional)", relationCtrl),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .collection("contacts")
                    .add({
                  "name": nameCtrl.text.trim(),
                  "phone": phoneCtrl.text.trim(),
                  "relation": relationCtrl.text.trim(),
                  "createdAt": Timestamp.now(),
                });

                Navigator.pop(context);
              },
              child: const Text("Save Contact",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }
}
