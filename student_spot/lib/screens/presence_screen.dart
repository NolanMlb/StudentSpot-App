import 'dart:convert';
import 'dart:io';
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
    final int idCours = args['cours'];
    _loadEleves(idClasse, idCours);
  }

  Future<void> _loadEleves(int idClasse, int idCours) async {
    try {
      final response = await PresenceRequest.getElevesByIdClasse(idClasse);
      final responsePresence =
          await PresenceRequest.getPresenceByIdCours(idCours);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final decodedResponsePresence =
          json.decode(responsePresence.body) as List<dynamic>;
      final presence = decodedResponsePresence;
      List eleves = decodedResponse;
      for (int i = 0; i < eleves.length; i++) {
        for (int j = 0; j < presence.length; j++) {
          if (presence[j]['eleve'] == eleves[i]['id']) {
            eleves[i]['id_presence'] = presence[j]['id'];
            eleves[i]['statut_presence'] = presence[j]['statut_presence'];
            break;
          }
        }
      }
      setState(() {
        _eleves = eleves;
        _eleves.forEach((element) {
          if (element['statut_presence'] == 'Present') {
            element['divColor'] = const Color(0xFFD9FFD9);
            element['borderColor'] = const Color(0xFF4DCB4D);
          } else {
            element['divColor'] = const Color(0xFFFFD9D9);
            element['borderColor'] = const Color(0xFFCB4D4D);
          }
          _elevesPresent.add({
            'id': element['id_presence'],
            'statut_presence': element['statut_presence'],
            'eleve': element['id'],
            'cours': idCours
          });
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
    final int idCours = args['cours'];
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
                                if (_eleves[index]['statut_presence'] ==
                                    'Present') {
                                  setState(() {
                                    _eleves[index]['divColor'] =
                                        const Color(0xFFFFD9D9);
                                    _eleves[index]['borderColor'] =
                                        const Color(0xFFCB4D4D);
                                    _eleves[index]['statut_presence'] =
                                        'Absent';
                                  });
                                  _eleves[index]['statut_presence'] = 'Absent';
                                  // change statut_presence to Absent in _elevesPresent
                                  _elevesPresent
                                      .firstWhere((e) =>
                                          e['eleve'] == _eleves[index]['id'])
                                      .update(
                                          'statut_presence', (_) => 'Absent');
                                } else {
                                  setState(() {
                                    _eleves[index]['divColor'] =
                                        Color(0xFFD9FFD9);
                                    _eleves[index]['borderColor'] =
                                        Color(0xFF4DCB4D);
                                    _eleves[index]['statut_presence'] =
                                        'Present';
                                  });
                                  _elevesPresent
                                      .firstWhere((e) =>
                                          e['eleve'] == _eleves[index]['id'])
                                      .update(
                                          'statut_presence', (_) => 'Present');
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
                                          child: _eleves[index]
                                                      ['eleve_photo'] !=
                                                  null
                                              ? Image.asset(
                                                  "assets/img/eleves_img/${_eleves[index]['eleve_photo']}",
                                                  height: 140.0)
                                              : ClipRRect(
                                                  child: Image.asset(
                                                    'assets/img/eleve_test.jpeg',
                                                    height: 140.0,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                            "${_eleves[index]['nom_eleve']} ${_eleves[index]['prenom_eleve']}",
                                            style: const TextStyle(
                                                fontSize: 15,
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
                    onPressed: () async {
                      await PresenceRequest.setPresence(
                          idCours, _elevesPresent);
                      Navigator.pop(context);
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
