import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anggota.dart';

class AnggotaService {
  static const String baseUrl = 'http://localhost/api/anggota.php';

  Future<List<Anggota>> getAnggota() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> data = responseData['data'];
          return data.map((json) => Anggota.fromJson(json)).toList();
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to load anggota');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addAnggota(Anggota anggota) async {
    try {
      print('Mencoba koneksi ke: $baseUrl');
      
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nim': anggota.nim,
          'nama': anggota.nama,
          'alamat': anggota.alamat,
          'jenis_kelamin': anggota.jenisKelamin,
        }),
      );

      print('Status Response: ${response.statusCode}');
      print('Body Response: ${response.body}');

    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal koneksi ke server: $e');
    }
  }

  Future<void> updateAnggota(Anggota anggota) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(anggota.toJson()),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to update anggota');
    }
  }

  Future<void> deleteAnggota(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl?id=$id'),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete anggota');
    }
  }
} 