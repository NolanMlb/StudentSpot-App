// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EcoleScreen extends StatelessWidget {
  const EcoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 80.0),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/img/logo.png', height: 48),
            ),
          ),
          SizedBox(height: 35.0),
          Container(
            margin: EdgeInsets.only(left: 40.0),
            alignment: Alignment.topLeft,
            child: const Text(
              'Sélectionnez votre école',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Unbounded',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
