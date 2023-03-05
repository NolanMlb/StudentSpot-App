import 'package:flutter/material.dart';

class PresenceScreen extends StatelessWidget {
  const PresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
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
              margin: const EdgeInsets.symmetric(vertical: 60.0),
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
        )));
  }
}
