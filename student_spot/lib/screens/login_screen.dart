// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../requests/loginRequest.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Controllers for the text fields
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          // Padding for the whole screen
          padding: const EdgeInsets.all(16.0),
          // Column for the whole screen
          child: Container(
            margin: const EdgeInsets.only(top: 120.0),
            child: Column(
              // Center the content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Logo
                Image.asset('assets/img/logo.png', height: 67),
                SizedBox(height: 82.0),
                // Title
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
                  // Subtitle
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
                // Space between the title and the form
                SizedBox(height: 32.0),
                // Start of the form
                Padding(
                  // Username label
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
                // Username input
                TextFormField(
                  // Link the controller to the text field
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  // Password label
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
                // Password input
                TextFormField(
                  // Link the controller to the text field
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 32.0),
                // Login button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // Button container
                    width: double.infinity,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // Button action
                        onPressed: () async {
                          http.Response response =
                              await LoginRequest.getUserByLoginAndPassword(
                            usernameController.text,
                            passwordController.text,
                          );
                          if (response.statusCode == 200) {
                            // Extract the token from the response
                            var token = response.body;
                            // Save the token in the shared preferences
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('token', token);
                            var decodedToken = JwtDecoder.decode(token);
                            // If the user is not an admin or a teacher
                            if (decodedToken['role'] != 1 &&
                                decodedToken['role'] != 3) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                // Display an error message
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Erreur de connexion"),
                                    content: Text(
                                        "Vous n'êtes pas autorisé à accéder à cette application"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/ecole');
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              // Display an error message if the login or password is incorrect
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Erreur de connexion"),
                                  content: Text(
                                      "Le nom d'utilisateur ou le mot de passe est incorrect"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        // Button style
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
