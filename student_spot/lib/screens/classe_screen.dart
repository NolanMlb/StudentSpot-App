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
    // Get the arguments passed from EcoleScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int idEcole = args['ecole'];
    _loadClasses(idEcole);
  }

  Future<void> _loadClasses(int idEcole) async {
    try {
      // Call the flutter request to get the classes
      final response = await ClasseRequest.getClasseByIdEcole(idEcole);
      // Decode the response
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      // Put the classes list in a variable
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
    // get data from previous screen
    final Map<Object, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<Object, dynamic>;
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
            children: <Widget>[
              const SizedBox(height: 35.0),
              Container(
                // Set the left margin for the title
                margin: const EdgeInsets.only(left: 40.0),
                alignment: Alignment.topLeft,
                // Show the title of the page
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
              _classes.isEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Vous n\'avez pas encore de classe',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: 'Unbounded',
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  : const SizedBox(height: 35.0),
              // for each classes in the list, show a button
              ..._classes.map(
                (classe) => Padding(
                    // Set the padding between the buttons
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SizedBox(
                      // Full width button
                      width: double.infinity,
                      child: Container(
                        // Set the left and right margin for the button
                        margin: const EdgeInsets.only(left: 40.0, right: 30.0),
                        // Set the border decoration for the button
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                          // Set the shadow for the button
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
                            // Set the background color for the button
                            backgroundColor: const Color(0xFFEDECF8),
                            // Set the padding for the button
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                          onPressed: () {
                            // Navigate to the CoursScreen
                            Navigator.pushNamed(context, '/cours',
                                arguments: {'classe': classe['id']});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(width: 30.0),
                              Text(
                                // Decode the class name from utf8 and show it
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
          // Set the position and style of the bottom buttons
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
                        // Redirect to the profil screen
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
