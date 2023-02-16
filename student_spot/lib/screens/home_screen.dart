import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/img/logo.png',
                  height: 48,
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
