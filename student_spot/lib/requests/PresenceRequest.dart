import 'dart:convert';

import 'package:http/http.dart' as http;

class PresenceRequest {
  static Future<http.Response> getElevesByIdClasse(int id_classe) async {
    return await http.get(Uri.parse('http://127.0.0.1:8080/eleves/$id_classe'));
  }

  static Future<http.Response> getPresenceByIdCours(int id_cours) async {
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/cours/$id_cours/presences'));
  }

  static Future<http.Response> setPresence(
      int id_cours, List<dynamic> elevesPresent) async {
    final dataToSend = json.encode(elevesPresent);
    return await http.put(
        Uri.parse('http://127.0.0.1:8080/cours/$id_cours/presences'),
        body: dataToSend,
        headers: {'Content-Type': 'application/json'});
  }
}
