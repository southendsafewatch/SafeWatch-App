import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          _section("General"),
          _tile(Icons.person, "Profile", () => Navigator.pushNamed(context, "/profile")),
          _tile(Icons.lock, "Privacy & Security", () {}),
          _tile(Icons.notifications, "Notifications", () {}),
          _tile(Icons.language, "Language", () {}),

          const SizedBox(height: 30),

          _section("Appearance"),
          _tile(Icons.dark_mode, "Dark Mode", () {}),
          _tile(Icons.color_lens, "Theme Colors", () {}),

          const SizedBox(height: 30),

          _section("Support"),
          _tile(Icons.help, "Help & FAQ", () {}),
          _tile(Icons.email, "Contact Support", () {}),
          _tile(Icons.info, "About SafeWatch", () {}),

          const SizedBox(height: 40),

          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: const Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _tile(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }
}
