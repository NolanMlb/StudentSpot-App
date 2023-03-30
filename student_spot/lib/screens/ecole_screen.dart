import 'package:flutter/material.dart';
import 'dart:convert';
import '../requests/ecoleRequest.dart';
import '../requests/loginRequest.dart';
import 'presence_screen.dart';
import 'profil_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EcoleScreen extends StatefulWidget {
  const EcoleScreen({Key? key}) : super(key: key);

  @override
  EcoleScreenState createState() => EcoleScreenState();
}

class EcoleScreenState extends State<EcoleScreen> {
  late SharedPreferences prefs;
  String? token;
  Map<String, dynamic> userInfo = {};
  List<dynamic> _schools = [];

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<int> initPreferences() async {
    // Extract the token from the shared preferences
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // Decode the token to get the user informations
    final userInfo = JwtDecoder.decode(token!);
    setState(() {});
    // Get the group id of the user
    final int userGroupId = userInfo['groupe'];
    return userGroupId;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // Get the arguments passed from LoginScreen
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Get the group id of the user
    final int userGroupId = await initPreferences();
    // Call the function to load the schools according to the user group id
    _loadSchools(userGroupId);
  }

  Future<void> _loadSchools(int userGroupId) async {
    try {
      // Call the flutter request to get the shools
      final response = await EcoleRequest.getEcoleByIdGroupe(userGroupId);
      final decodedResponse = json.decode(response.body) as List<dynamic>;
      // Put the scools list in a variable
      final schools = decodedResponse;
      setState(() {
        _schools = schools;
      });
    } catch (e) {
      print('Failed to load schools: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
              const SizedBox(height: 35.0),
              // Show the title of the page
              Container(
                // Set margin to the left
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
              // Set the margin between the title and the list of schools
              _schools.isEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Vous n\'avez pas encore d\'école',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: 'Unbounded',
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                  : const SizedBox(height: 35.0),
              // For each school, show a button
              ..._schools.map(
                (ecole) => Padding(
                    // Padding between schools
                    padding: const EdgeInsets.only(bottom: 30.0),
                    // Set the button width to the full width of the screen
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        // Set the margin to the left and right
                        margin: const EdgeInsets.only(left: 40.0, right: 30.0),
                        decoration: BoxDecoration(
                          // Set the border radius
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(
                            // Set the border color
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: 1,
                          ),
                          // Set the shadow of the button
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
                            // Set the background color of the button plus the height
                            backgroundColor: const Color(0xFFEDECF8),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                          // Set the action when the button is pressed
                          onPressed: () {
                            // Navigate to the classe screen and pass the school id
                            Navigator.pushNamed(context, '/classe',
                                arguments: {'ecole': ecole['id']});
                          },
                          child: Row(
                            // Set the alignment of the text to the left
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // Set the margin of the text
                              const SizedBox(width: 30.0),
                              // Show the school name
                              Text(
                                ecole['nom_ecole'],
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
