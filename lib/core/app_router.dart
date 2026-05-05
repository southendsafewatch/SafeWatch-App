import 'package:flutter/material.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/sos/sos_screen.dart';
import '../features/profile/profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case "/":
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case "/map":
        return MaterialPageRoute(builder: (_) => const MapScreen());

      case "/sos":
        return MaterialPageRoute(builder: (_) => const SosScreen());

      case "/profile":
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
