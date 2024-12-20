import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/peminjaman.dart';
import '../services/peminjaman_service.dart';
import '../models/anggota.dart';
import '../services/anggota_service.dart';
import '../models/buku.dart';
import '../services/buku_service.dart';

class FormPeminjamanPage extends StatefulWidget {
  final String? selectedBookId;
  
  const FormPeminjamanPage({
    super.key,
    this.selectedBookId,
  });

  @override
  State<FormPeminjamanPage> createState() => _FormPeminjamanPageState();
}

class _FormPeminjamanPageState extends State<FormPeminjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final PeminjamanService _peminjamanService = PeminjamanService();
  final AnggotaService _anggotaService = AnggotaService();
  final BukuService _bukuService = BukuService();
  
  List<Anggota> _anggotaList = [];
  List<Buku> _bukuList = [];
  String? _selectedAnggotaId;
  String? _selectedBukuId;
  DateTime _tanggalPinjam = DateTime.now();
  DateTime _tanggalKembali = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _loadAnggota();
    _loadBuku();
    // Set selected book if provided
    if (widget.selectedBookId != null) {
      _selectedBukuId = widget.selectedBookId;
    }
  }

  Future<void> _loadAnggota() async {
    try {
      final anggota = await _anggotaService.getAnggota();
      setState(() => _anggotaList = anggota);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading anggota: $e')),
        );
      }
    }
  }

  Future<void> _loadBuku() async {
    try {
      final buku = await _bukuService.getBuku();
      setState(() => _bukuList = buku);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading buku: $e')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _tanggalPinjam : _tanggalKembali,
      firstDate: isStartDate ? DateTime.now() : _tanggalPinjam,
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _tanggalPinjam = picked;
          // Update tanggal kembali jika tanggal pinjam lebih besar
          if (_tanggalKembali.isBefore(_tanggalPinjam)) {
            _tanggalKembali = _tanggalPinjam.add(const Duration(days: 7));
          }
        } else {
          _tanggalKembali = picked;
        }
      });
    }
  }

  Widget _buildDateField({
    required String title,
    required DateTime value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8B7355)),
        title: Text(title),
        subtitle: Text(DateFormat('dd/MM/yyyy').format(value)),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman'),
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
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedAnggotaId,
                        decoration: InputDecoration(
                          labelText: 'Pilih Anggota',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF8B7355)),
                        ),
                        items: _anggotaList.map((anggota) {
                          return DropdownMenuItem(
                            value: anggota.id,
                            child: Text('${anggota.nim} - ${anggota.nama}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedAnggotaId = value);
                        },
                        validator: (value) {
                          if (value == null) return 'Pilih anggota';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedBukuId,
                        decoration: InputDecoration(
                          labelText: 'Pilih Buku',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.book, color: Color(0xFF8B7355)),
                        ),
                        items: _bukuList.map((buku) {
                          return DropdownMenuItem(
                            value: buku.id,
                            child: Text(buku.judul),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedBukuId = value);
                        },
                        validator: (value) {
                          if (value == null) return 'Pilih buku';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildDateField(
                        title: 'Tanggal Pinjam',
                        value: _tanggalPinjam,
                        icon: Icons.calendar_today,
                        onTap: () => _selectDate(context, true),
                      ),
                      const SizedBox(height: 16),
                      _buildDateField(
                        title: 'Tanggal Kembali',
                        value: _tanggalKembali,
                        icon: Icons.event,
                        onTap: () => _selectDate(context, false),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B7355),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final peminjaman = Peminjaman(
                                id: '0',
                                idAnggota: _selectedAnggotaId!,
                                idBuku: _selectedBukuId!,
                                tanggalPinjam: DateFormat('yyyy-MM-dd').format(_tanggalPinjam),
                                tanggalKembali: DateFormat('yyyy-MM-dd').format(_tanggalKembali),
                              );
                              
                              await _peminjamanService.addPeminjaman(peminjaman);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Peminjaman berhasil ditambahkan'),
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
                          'Simpan Peminjaman',
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
} 