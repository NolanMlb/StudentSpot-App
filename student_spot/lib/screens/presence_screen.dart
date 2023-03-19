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
  List<dynamic> _elevesPresent = [];
  Color divColor = Color(0xFFFFD9D9);
  Color borderColor = Color(0xFFCB4D4D);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupération des arguments passés depuis LoginScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final int userId = args['userId'];
    final user = args['user'];
    final int idClasse = args['classe'];
    _loadEleves(idClasse);
  }

  Future<void> _loadEleves(int idClasse) async {
    try {
      final response = await PresenceRequest.getElevesByIdClasse(idClasse);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final eleves = decodedResponse;
      setState(() {
        _eleves = eleves;
        _eleves.forEach((element) {
          element['divColor'] = Color(0xFFFFD9D9);
          element['borderColor'] = Color(0xFFCB4D4D);
        });
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
          Column(
            children: [
              Container(
                // height
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
                margin: const EdgeInsets.only(left: 40, top: 10.0),
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
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        itemCount: _eleves.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                // insert eleve in list
                                if (_elevesPresent.contains(_eleves[index])) {
                                  setState(() {
                                    _eleves[index]['divColor'] =
                                        Color(0xFFFFD9D9);
                                    _eleves[index]['borderColor'] =
                                        Color(0xFFCB4D4D);
                                  });
                                  _elevesPresent.remove(_eleves[index]);
                                } else {
                                  setState(() {
                                    _eleves[index]['divColor'] =
                                        Color(0xFFD9FFD9);
                                    _eleves[index]['borderColor'] =
                                        Color(0xFF4DCB4D);
                                  });
                                  _elevesPresent.add(_eleves[index]);
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: _eleves[index]['divColor'],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _eleves[index]['borderColor'],
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 12.0),
                                      child: Column(children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            'assets/img/eleve_test.jpeg',
                                            height: 140.0,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                            "${_eleves[index]['nom_eleve']} ${_eleves[index]['prenom_eleve']}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Unbounded',
                                                fontWeight: FontWeight.bold))
                                      ]),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ))),
              Container(
                width: 300,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                // margin top 60 and bottom 100
                margin: const EdgeInsets.only(top: 20.0, bottom: 150.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print(_elevesPresent);
                    },
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
      ),
    );
  }
}
