import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class BukuService {
  static const String baseUrl = 'http://localhost/api/buku.php';
  
  Future<List<Buku>> getBuku() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> data = responseData['data'];
          return data.map((json) => Buku.fromJson(json)).toList();
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to load buku');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addBuku(Buku buku) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(buku.toJson()),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to add buku: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 