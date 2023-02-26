import 'package:flutter/material.dart';

import 'presence_screen.dart';

class EcoleScreen extends StatelessWidget {
  const EcoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 80.0),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/img/logo.png', height: 48),
            ),
          ),
          const SizedBox(height: 35.0),
          Container(
            margin: const EdgeInsets.only(left: 40.0),
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
          const SizedBox(height: 35.0),
          SizedBox(
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.only(left: 40.0, right: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //
                  backgroundColor: const Color(0xFFEDECF8),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PresenceScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(width: 30.0),
                    const Text(
                      'WebTech',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Unbounded',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}