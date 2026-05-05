import 'package:flutter/material.dart';

// AUTH SCREENS
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/auth/role_select_screen.dart';
import 'features/sos/sos_alert_viewer.dart';

// AUTH GATE
import 'core/auth/auth_gate.dart';

// MAIN APP SCREENS
import 'features/home/home_screen.dart';
import 'features/map/map_screen.dart';
import 'features/sos/sos_screen.dart';
import 'features/profile/profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // AUTH GATE (STARTUP)
      case "/auth":
        return MaterialPageRoute(
          builder: (_) => const AuthGate(
            home: HomeScreen(),
            login: LoginScreen(),
          ),
        );

      // LOGIN + REGISTER + ROLE
      case "/":
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case "/register":
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case "/role":
        return MaterialPageRoute(builder: (_) => const RoleSelectScreen());

      case "/alerts":
        return MaterialPageRoute(builder: (_) => const SosAlertViewer());

      // MAIN APP
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case "/map":
        return MaterialPageRoute(builder: (_) => const MapScreen());

      case "/sos":
        return MaterialPageRoute(builder: (_) => const SosScreen());

      case "/profile":
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      // UNKNOWN ROUTE
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
