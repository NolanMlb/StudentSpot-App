import 'package:flutter/material.dart';
import 'package:student_spot/screens/home_screen.dart';
import 'package:student_spot/screens/login_screen.dart';
import 'package:student_spot/screens/ecole_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StudentSpot',
      home: EcoleScreen(),
    );
  }
}
