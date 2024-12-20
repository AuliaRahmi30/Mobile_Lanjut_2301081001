import 'package:flutter/material.dart';
import '../services/peminjaman_service.dart';
import 'form_peminjaman_page.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final PeminjamanService _peminjamanService = PeminjamanService();
  List<Map<String, dynamic>> _peminjamanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPeminjaman();
  }

  Future<void> _loadPeminjaman() async {
    try {
      final response = await _peminjamanService.getPeminjaman();
      setState(() {
        _peminjamanList = (response['data'] as List)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Peminjaman'),
        backgroundColor: const Color(0xFF8B7355),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B7355), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _peminjamanList.length,
                itemBuilder: (context, index) {
                  final peminjaman = _peminjamanList[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Peminjaman #${peminjaman['id'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B7355).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Dipinjam',
                                  style: TextStyle(
                                    color: Color(0xFF8B7355),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.person_outline, 
                                color: Color(0xFF8B7355), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${peminjaman['nama_anggota'] ?? ''} (${peminjaman['nim_anggota'] ?? ''}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.book_outlined, 
                                color: Color(0xFF8B7355), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${peminjaman['judul_buku'] ?? ''}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.date_range, 
                                color: Color(0xFF8B7355), size: 20),
                              const SizedBox(width: 8),
                              Text(
                                '${peminjaman['tanggal_pinjam'] ?? ''} s/d ${peminjaman['tanggal_kembali'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPeminjamanPage()),
          );
          if (result == true) {
            _loadPeminjaman();
          }
        },
        backgroundColor: const Color(0xFF8B7355),
        child: const Icon(Icons.add),
      ),
    );
  }
} 