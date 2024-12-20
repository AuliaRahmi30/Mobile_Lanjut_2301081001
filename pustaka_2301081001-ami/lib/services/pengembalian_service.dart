import 'dart:convert';
import 'package:http/http.dart' as http;

class PengembalianService {
  static const String baseUrl = 'http://localhost/api/pengembalian.php';

  Future<Map<String, dynamic>> getPengembalian() async {
    final response = await http.get(Uri.parse(baseUrl));
    return json.decode(response.body);
  }

  Future<void> addPengembalian(Map<String, dynamic> data) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }
} 