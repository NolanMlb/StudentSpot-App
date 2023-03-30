import 'package:http/http.dart' as http;

class ClasseRequest {
  // Get the classes according to the school id
  static Future<http.Response> getClasseByIdEcole(int id_ecole) async {
    // Call the springboot API
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/getClasseByIdEcole/$id_ecole'));
  }
}
