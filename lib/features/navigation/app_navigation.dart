import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:safewatch/features/home/home_screen.dart';
import 'package:safewatch/features/map/map_screen.dart';
import 'package:safewatch/features/sos/sos_screen.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int index = 0;

  final screens = const [
    HomeScreen(),
    MapScreen(),
    SosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],

      // MODERN GLASS NAV BAR
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home_rounded, "Home", 0),
                _navItem(Icons.map_rounded, "Map", 1),
                _navItem(Icons.warning_amber_rounded, "SOS", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int i) {
    final active = index == i;

    return GestureDetector(
      onTap: () => setState(() => index = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.black.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: active ? 28 : 24,
              color: active ? Colors.black : Colors.black54,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: active ? 14 : 12,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? Colors.black : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
