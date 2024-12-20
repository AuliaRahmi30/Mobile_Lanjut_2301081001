import 'package:flutter/material.dart';
import '../models/buku.dart';
import '../services/buku_service.dart';

class FormBukuPage extends StatefulWidget {
  const FormBukuPage({super.key});

  @override
  State<FormBukuPage> createState() => _FormBukuPageState();
}

class _FormBukuPageState extends State<FormBukuPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _pengarangController = TextEditingController();
  final _penerbitController = TextEditingController();
  final _tahunTerbitController = TextEditingController();
  final _imageController = TextEditingController();
  final BukuService _bukuService = BukuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Buku'),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.book_outlined,
                        size: 50,
                        color: Color(0xFF8B7355),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _judulController,
                        decoration: InputDecoration(
                          labelText: 'Judul Buku',
                          prefixIcon: const Icon(Icons.book, color: Color(0xFF8B7355)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Judul buku harus diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _pengarangController,
                        decoration: InputDecoration(
                          labelText: 'Pengarang',
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF8B7355)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pengarang harus diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _penerbitController,
                        decoration: InputDecoration(
                          labelText: 'Penerbit',
                          prefixIcon: const Icon(Icons.business, color: Color(0xFF8B7355)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _tahunTerbitController,
                        decoration: InputDecoration(
                          labelText: 'Tahun Terbit',
                          prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF8B7355)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _imageController,
                        decoration: InputDecoration(
                          labelText: 'URL Gambar',
                          prefixIcon: const Icon(Icons.image, color: Color(0xFF8B7355)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B7355),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final buku = Buku(
                              id: '0',
                              judul: _judulController.text,
                              pengarang: _pengarangController.text,
                              penerbit: _penerbitController.text,
                              tahunTerbit: _tahunTerbitController.text,
                              image: _imageController.text,
                            );
                            
                            try {
                              await _bukuService.addBuku(buku);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Buku berhasil ditambahkan'),
                                    backgroundColor: Color(0xFF8B7355),
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pengarangController.dispose();
    _penerbitController.dispose();
    _tahunTerbitController.dispose();
    _imageController.dispose();
    super.dispose();
  }
} 