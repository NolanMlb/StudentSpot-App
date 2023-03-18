import 'package:http/http.dart' as http;

class PresenceRequest {
  static Future<http.Response> getElevesByIdClasse(int id_classe) async {
    return await http
        .get(Uri.parse('http://127.0.0.1:8080/getClasseByIdEcole/$id_classe'));
  }
}
