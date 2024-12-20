import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {

  static const String baseUrl = 'http://localhost/api/login.php';
  
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      print('Trying to login with: $username'); 
      
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      
      print('Response: ${response.body}'); 
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['success'] == true) {
          return {
            'success': true,
            'message': responseData['message'],
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Login gagal',
          };
        }
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      print('Login error: $e'); 
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}