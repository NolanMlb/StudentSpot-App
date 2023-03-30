import 'package:http/http.dart' as http;

class LoginRequest {
  // Login and password are sent to the springboot API
  static Future<http.Response> getUserByLoginAndPassword(
      String login, String password) async {
    // Call the springboot API
    return await http.get(Uri.parse(
        'http://127.0.0.1:8080/getUserByLoginAndPassword?login=$login&password=$password'));
  }
}
