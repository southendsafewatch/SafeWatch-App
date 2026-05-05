import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({super.key});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final relationCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final id = args["id"];
    final data = args["data"];

    nameCtrl.text = data["name"];
    phoneCtrl.text = data["phone"];
    relationCtrl.text = data["relation"] ?? "";

    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Edit Contact"),
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

            // SAVE BUTTON
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
                    .doc(id)
                    .update({
                  "name": nameCtrl.text.trim(),
                  "phone": phoneCtrl.text.trim(),
                  "relation": relationCtrl.text.trim(),
                });

                Navigator.pop(context);
              },
              child: const Text("Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            const SizedBox(height: 20),

            // DELETE BUTTON
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .collection("contacts")
                    .doc(id)
                    .delete();

                Navigator.pop(context);
              },
              child: const Text(
                "Delete Contact",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
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
