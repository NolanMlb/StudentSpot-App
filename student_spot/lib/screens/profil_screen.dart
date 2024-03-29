import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'presence_screen.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  ProfilScreenState createState() => ProfilScreenState();
}

class ProfilScreenState extends State<ProfilScreen> {
  late SharedPreferences prefs;
  String? token;
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      setState(() {
        this.prefs = pref;
        token = prefs.getString('token');
        // Décodage du token
        userInfo = JwtDecoder.decode(token!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // start of the screen
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/img/logo.png', // Chemin d'accès au fichier du logo
          fit: BoxFit.contain, // Ajuster la taille du logo
          height: 48.0, // Hauteur maximale du logo
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 40.0, top: 30.0),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Vos informations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Unbounded',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 40.0, top: 10.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Nom d\'utilisateur: ${userInfo['sub']}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Unbounded',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 10.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Nom: ${userInfo['nom']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Unbounded',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 10.0),
                    alignment: Alignment.topLeft,
                    // Affichage du prénom de l'utilisateur
                    child: Text(
                      'Prénom: ${userInfo['prenom']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Unbounded',
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    margin: const EdgeInsets.symmetric(vertical: 60.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Delete token
                        await prefs.remove('token');
                        // Redirect to login page
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        // btn color
                        primary: Colors.black,
                        fixedSize: const Size(200, 50),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Déconnexion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Unbounded',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 110,
            right: 110,
            bottom: 40,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.check_box, color: Colors.black),
                      style: ElevatedButton.styleFrom(
                          elevation: 1,
                          fixedSize: const Size(56, 56),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.person, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(56, 56),
                          primary: Colors.black,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
