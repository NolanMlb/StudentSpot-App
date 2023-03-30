import 'package:http/http.dart' as http;

class CoursRequest {
  // Get the lessons of a class if the user is an admin
  static Future<http.Response> getCoursByClasse(int id_classe) async {
    // Call to springboot api
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getCoursByClasse?id_classe=$id_classe'));
  }

  // Get the lessons of the teacher by his id and by class id
  static Future<http.Response> getCoursByIntervenant(
      int id_classe, int id_intervenant) async {
    // Call to springboot api
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getCoursByIntervenant?id_classe=$id_classe&id_intervenant=$id_intervenant'));
  }
}
