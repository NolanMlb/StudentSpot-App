import 'package:http/http.dart' as http;

class LoginRequest {
  static Future<http.Response> getUserByLoginAndPassword(
      String login, String password) async {
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getUserByLoginAndPassword?login=$login&password=$password'));
  }
}
