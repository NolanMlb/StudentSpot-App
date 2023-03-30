import 'package:http/http.dart' as http;

class EcoleRequest {
  // Get the schools according to the user group id
  static Future<http.Response> getEcoleByIdGroupe(int id_groupe) async {
    // Call the springboot API
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/getEcoleByIdGroupe/$id_groupe'));
  }
}
