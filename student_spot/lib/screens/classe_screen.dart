import 'package:flutter/material.dart';
import 'dart:convert';
import '../requests/classeRequest.dart';
import '../requests/loginRequest.dart';
import 'presence_screen.dart';
import 'profil_screen.dart';

class ClasseScreen extends StatefulWidget {
  const ClasseScreen({Key? key}) : super(key: key);

  @override
  ClasseScreenState createState() => ClasseScreenState();
}

class ClasseScreenState extends State<ClasseScreen> {
  List<dynamic> _classes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupération des arguments passés depuis EcoleScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int idEcole = args['ecole'];
    _loadClasses(idEcole);
  }

  Future<void> _loadClasses(int idEcole) async {
    try {
      final response = await ClasseRequest.getClasseByIdEcole(idEcole);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final classes = decodedResponse;
      setState(() {
        _classes = classes;
      });
    } catch (e) {
      print('Failed to load classes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<Object, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<Object, dynamic>;
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
                  'Sélectionnez votre classe',
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
              ..._classes.map(
                (classe) => Padding(
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
                            Navigator.pushNamed(context, '/cours',
                                arguments: {'classe': classe['id']});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(width: 30.0),
                              Text(
                                // Décodage des caractères spéciaux du champ nom_classe
                                utf8.decode(classe['nom_classe'].codeUnits),
                                style: const TextStyle(
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
