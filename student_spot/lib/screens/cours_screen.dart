import 'package:flutter/material.dart';
import 'dart:convert';
import '../requests/coursRequest.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursScreen extends StatefulWidget {
  const CoursScreen({Key? key}) : super(key: key);

  @override
  CoursScreenState createState() => CoursScreenState();
}

class CoursScreenState extends State<CoursScreen> {
  late SharedPreferences prefs;
  String? token;
  Map<String, dynamic> userInfo = {};
  List<dynamic> _cours = [];
  int idClasse = 0;
  var hdebut;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<Map<String, dynamic>> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // Décodage du token
    final userInfo = JwtDecoder.decode(token!);
    setState(() {});
    return userInfo;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // Récupération des arguments passés depuis ClasseScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int idClasse = args['classe'];
    final Map<String, dynamic> userInfo = await initPreferences();
    final int userRoleId = userInfo['role'];
    final int userId = userInfo['id'];
    _loadCours(idClasse, userRoleId, userId);
  }

  Future<void> _loadCours(int idClasse, int userRoleId, int userId) async {
    try {
      if (userRoleId == 3) {
        final response =
            await CoursRequest.getCoursByIntervenant(idClasse, userId);
        final decodedResponse = json.decode(response.body) as List<dynamic>;
        final cours = decodedResponse;
        setState(() {
          _cours = cours;
        });
      } else {
        final response = await CoursRequest.getCoursByClasse(idClasse);
        final decodedResponse = json.decode(response.body) as List<dynamic>;
        final cours = decodedResponse;
        setState(() {
          _cours = cours;
        });
      }
    } catch (e) {
      print('Failed to load cours: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<Object, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<Object, dynamic>;
    final classe = args['classe'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
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
                  'Sélectionnez votre cours',
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
              ..._cours.map(
                (cours) => Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SizedBox(
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
                            Navigator.pushNamed(context, '/presence',
                                arguments: {
                                  'cours': cours['id'],
                                  'classe': classe
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(width: 30.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // Décodage des caractères spéciaux du champ nom_classe
                                      utf8.decode(cours['nom_cours'].codeUnits),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Unbounded',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Text(
                                          cours['heure_debut'].replaceAll(
                                                  "1970-01-01T", "") +
                                              "   ---   ",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'Unbounded',
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        Text(
                                          cours['heure_fin']
                                              .replaceAll("1970-01-01T", ""),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'Unbounded',
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    )),
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
                        Navigator.pushNamed(context, '/profil');
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
