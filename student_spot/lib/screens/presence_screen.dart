import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'profil_screen.dart';
import '../requests/presenceRequest.dart';

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({Key? key}) : super(key: key);

  @override
  PresenceScreenState createState() => PresenceScreenState();
}

class PresenceScreenState extends State<PresenceScreen> {
  List<dynamic> _eleves = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupération des arguments passés depuis LoginScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final int userId = args['userId'];
    final user = args['user'];
    final int idClasse = args['classe'];
    _loadClasses(idClasse);
  }

  Future<void> _loadClasses(int idClasse) async {
    try {
      final response = await PresenceRequest.getElevesByIdClasse(idClasse);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final eleves = decodedResponse;
      setState(() {
        _eleves = eleves;
      });
    } catch (e) {
      print('Failed to load eleves: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final user = args['user'];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Image.asset(
            'assets/img/logo.png', // Chemin d'accès au fichier du logo
            fit: BoxFit.contain, // Ajuster la taille du logo
            height: 48.0, // Hauteur maximale du logo
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 40.0, top: 30.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Vérifiez votre appel',
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
                  margin: const EdgeInsets.only(left: 40.0, top: 12.0),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Validez celui-ci une fois terminé.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Unbounded',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/eleve_test.jpeg',
                                  height: 140.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/img/eleve_test.jpeg',
                                    height: 140.0,
                                  )),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/eleve_test.jpeg',
                                  height: 140.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/eleve_test.jpeg',
                                  height: 140.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/eleve_test.jpeg',
                                  height: 140.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 26.0),
                      width: 160,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9FFE1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF40734B),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/img/eleve_test.jpeg',
                                  height: 140.0,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('Johnny Sins',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Unbounded',
                                      fontWeight: FontWeight.bold))
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 300,
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  // margin top 60 and bottom 100
                  margin: const EdgeInsets.only(top: 60.0, bottom: 150.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Valider',
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
                ),
              ],
            )),
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
                        onPressed: () {},
                        child: Icon(Icons.check_box, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                            elevation: 1,
                            fixedSize: const Size(56, 56),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ))),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                          Navigator.pushNamed(context, '/profil',
                              arguments: {'user': user});
                        },
                        child: Icon(Icons.person, color: Colors.black),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(56, 56),
                            primary: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
