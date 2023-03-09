import 'package:http/http.dart' as http;

class EcoleRequest {
  static Future<http.Response> getEcoleByIdGroupe(int id_groupe) async {
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/getEcoleByIdGroupe/$id_groupe'));
  }
}
