import 'package:http/http.dart' as http;

class CoursRequest {
  static Future<http.Response> getCoursByClasse(int id_classe) async {
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getCoursByClasse/id_classe=$id_classe'));
  }
}
