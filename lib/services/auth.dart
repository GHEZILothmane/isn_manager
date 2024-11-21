import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

class Auth {
  final String baseUrl = 'http://isn-manager.herokuapp.com';
  static final session = FlutterSession();

  Future<dynamic> login(String email, String password) async {
    try {
      var res = await http.post(
        Uri.parse('$baseUrl/api/auth'),
        body: {'email': email, 'password': password},
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to login: ${res.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error logging in');
    }
  }

  static Future<void> setToken(String token) async {
    await session.set('x-auth-token', token);
  }

  static Future<String> getToken() async {
    return await session.get('x-auth-token');
  }

  static Future<void> removeToken() async {
    await session.prefs.clear();
  }
}

