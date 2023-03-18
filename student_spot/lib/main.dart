import 'package:flutter/material.dart';
import 'package:student_spot/screens/ecole_screen.dart';
import 'package:student_spot/screens/login_screen.dart';
import 'package:student_spot/screens/presence_screen.dart';
import 'package:student_spot/screens/profil_screen.dart';
import 'package:student_spot/screens/classe_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentSpot',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/ecole': (context) => const EcoleScreen(),
        '/presence': (context) => const PresenceScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/classe': (context) => const ClasseScreen(),
      },
    );
  }
}
