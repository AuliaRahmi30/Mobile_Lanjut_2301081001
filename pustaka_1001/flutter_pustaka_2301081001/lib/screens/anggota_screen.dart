import 'package:flutter/material.dart';
import '../models/anggota.dart';
import 'daftar_anggota_screen.dart';

class AnggotaScreen extends StatefulWidget {
  @override
  _AnggotaScreenState createState() => _AnggotaScreenState();
}

class _AnggotaScreenState extends State<AnggotaScreen> {
  final TextEditingController _kodeAnggotaController = TextEditingController();
  final TextEditingController _namaAnggotaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();

  List<Anggota> _anggotaList = [];

  void _addAnggota() {
    setState(() {
      _anggotaList.add(Anggota(
        kodeAnggota: _kodeAnggotaController.text,
        namaAnggota: _namaAnggotaController.text,
        alamat: _alamatController.text,
        jenisKelamin: _jenisKelaminController.text,
      ));
    });

    // Clear the controllers
    _kodeAnggotaController.clear();
    _namaAnggotaController.clear();
    _alamatController.clear();
    _jenisKelaminController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Anggota berhasil ditambahkan')),
    );

    // Navigate to DaftarAnggotaScreen to display the list of members
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DaftarAnggotaScreen(anggotaList: _anggotaList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Anggota'),
        backgroundColor: Colors.blueAccent, // Warna aplikasi lebih fresh
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title
              Text(
                'Tambah Anggota Pustaka',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Isi data anggota baru di bawah ini:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),

              // Kode Anggota
              TextField(
                controller: _kodeAnggotaController,
                decoration: InputDecoration(
                  labelText: 'Kode Anggota',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),

              // Nama Anggota
              TextField(
                controller: _namaAnggotaController,
                decoration: InputDecoration(
                  labelText: 'Nama Anggota',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.account_circle),
                ),
              ),
              SizedBox(height: 16),

              // Alamat
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 16),

              // Jenis Kelamin
              TextField(
                controller: _jenisKelaminController,
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.transgender),
                ),
              ),
              SizedBox(height: 20),

              // Add Button
              Center(
                child: ElevatedButton(
                  onPressed: _addAnggota,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 137, 68), // Warna tombol sesuai tema
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Tambah Anggota'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
