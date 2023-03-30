import 'package:http/http.dart' as http;

class CoursRequest {
  static Future<http.Response> getCoursByClasse(int id_classe) async {
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getCoursByClasse?id_classe=$id_classe'));
  }

  static Future<http.Response> getCoursByIntervenant(
      int id_classe, int id_intervenant) async {
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getCoursByIntervenant?id_classe=$id_classe&id_intervenant=$id_intervenant'));
  }
}
