// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'ecole_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: const EdgeInsets.only(top: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/img/logo.png', height: 67),
                SizedBox(height: 82.0),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Bienvenue sur StudentSpot',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Unbounded',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Connectez-vous et procédez à vos appels',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Unbounded',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Nom d\'utilisateur',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Unbounded',
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Mot de passe',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Unbounded',
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 32.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EcoleScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Se connecter'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
