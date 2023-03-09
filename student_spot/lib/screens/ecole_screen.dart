import 'package:flutter/material.dart';
import 'dart:convert';
import '../requests/ecoleRequest.dart';
import '../requests/loginRequest.dart';
import 'presence_screen.dart';

class EcoleScreen extends StatefulWidget {
  const EcoleScreen({Key? key}) : super(key: key);

  @override
  EcoleScreenState createState() => EcoleScreenState();
}

class EcoleScreenState extends State<EcoleScreen> {
  List<String> _schoolNames = [];
  int _idGroupe = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadSchoolNames();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Récupération des arguments passés depuis LoginScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //final int userId = args['userId'];
    final int userGroupId = args['userGroupId'];
    _loadSchoolNames(userGroupId);
  }

  Future<void> _loadSchoolNames(int userGroupId) async {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int userGroupId = args['userGroupId'];

    try {
      final response = await EcoleRequest.getEcoleByIdGroupe(userGroupId);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      final schoolNames =
          decodedResponse.map((s) => s['nom_ecole'] as String).toList();
      setState(() {
        _schoolNames = schoolNames;
      });
    } catch (e) {
      print('Failed to load schools: $e');
    }
  }

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
          ..._schoolNames.map(
            (ecole) => Padding(
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
                          Text(
                            ecole,
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
    );
  }
}
