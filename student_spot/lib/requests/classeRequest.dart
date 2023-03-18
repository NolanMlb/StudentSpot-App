import 'package:http/http.dart' as http;

class ClasseRequest {
  static Future<http.Response> getClasseByIdEcole(int id_ecole) async {
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/getClasseByIdEcole/$id_ecole'));
  }
}
