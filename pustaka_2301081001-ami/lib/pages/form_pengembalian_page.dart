import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/peminjaman_service.dart';
import '../services/pengembalian_service.dart';

class FormPengembalianPage extends StatefulWidget {
  const FormPengembalianPage({super.key});

  @override
  State<FormPengembalianPage> createState() => _FormPengembalianPageState();
}

class _FormPengembalianPageState extends State<FormPengembalianPage> {
  final _formKey = GlobalKey<FormState>();
  final _pengembalianService = PengembalianService();
  DateTime _tanggalKembali = DateTime.now();
  String? _selectedPeminjamanId;
  List<Map<String, dynamic>> _peminjamanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPeminjaman();
  }

  Future<void> _loadPeminjaman() async {
    try {
      final response = await PeminjamanService().getPeminjaman();
      setState(() {
        _peminjamanList = List<Map<String, dynamic>>.from(response['data']);
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
        title: const Text('Form Pengembalian'),
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
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pilih Peminjaman',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedPeminjamanId,
                        items: _peminjamanList.map((peminjaman) {
                          return DropdownMenuItem(
                            value: peminjaman['id'].toString(),
                            child: Text(
                              '${peminjaman['nama_anggota']} - ${peminjaman['judul_buku']}',
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedPeminjamanId = value);
                        },
                        validator: (value) {
                          if (value == null) return 'Pilih peminjaman';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Tanggal Kembali'),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy').format(_tanggalKembali),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _tanggalKembali,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            setState(() => _tanggalKembali = picked);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B7355),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _pengembalianService.addPengembalian({
                                'id_peminjaman': _selectedPeminjamanId,
                                'tanggal_pengembalian': DateFormat('yyyy-MM-dd').format(_tanggalKembali),
                              });
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Pengembalian berhasil disimpan')),
                                );
                                Navigator.pop(context, true);
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            }
                          }
                        },
                        child: const Text('Simpan Pengembalian'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}