import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/peminjaman.dart';

class PeminjamanService {
  static const String baseUrl = 'http://localhost/api/peminjaman.php';
  
  Future<Map<String, dynamic>> getPeminjaman() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load peminjaman');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addPeminjaman(Peminjaman peminjaman) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'anggota_id': peminjaman.idAnggota,
          'buku_id': peminjaman.idBuku,
          'tanggal_pinjam': peminjaman.tanggalPinjam,
          'tanggal_kembali': peminjaman.tanggalKembali,
        }),
      );
      
      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        throw Exception(responseData['message'] ?? 'Failed to add peminjaman');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 