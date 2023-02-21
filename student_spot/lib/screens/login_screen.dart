import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(41.0),
                child: Image.asset('assets/img/logo.png', height: 48),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10, left: 39),
                child: const Text(
                  'Bienvenue sur StudentSpot',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Unbounded',
                      decoration: TextDecoration.none),
                ),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
