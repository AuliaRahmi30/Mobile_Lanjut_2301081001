import 'package:flutter/material.dart';
import 'form_pengembalian_page.dart';
import '../services/pengembalian_service.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  final PengembalianService _pengembalianService = PengembalianService();
  List<Map<String, dynamic>> _pengembalianList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPengembalian();
  }

  Future<void> _loadPengembalian() async {
    try {
      final response = await _pengembalianService.getPengembalian();
      setState(() {
        _pengembalianList = List<Map<String, dynamic>>.from(response['data']);
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
        title: const Text('Data Pengembalian'),
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
                itemCount: _pengembalianList.length,
                itemBuilder: (context, index) {
                  final pengembalian = _pengembalianList[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pengembalian #${pengembalian['id']}',
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
                                child: Text(
                                  'Denda: Rp ${pengembalian['denda']}',
                                  style: const TextStyle(
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
                                  '${pengembalian['nama_anggota']} (${pengembalian['nim_anggota']})',
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
                                  pengembalian['judul_buku'],
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
                                'Dikembalikan: ${pengembalian['tanggal_pengembalian']}',
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
            MaterialPageRoute(builder: (context) => const FormPengembalianPage()),
          );
          if (result == true) {
            _loadPengembalian();
          }
        },
        backgroundColor: const Color(0xFF8B7355),
        child: const Icon(Icons.add),
      ),
    );
  }
} 