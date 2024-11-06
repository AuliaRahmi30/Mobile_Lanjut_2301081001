import 'package:flutter/material.dart';
import '../models/buku.dart';
import 'daftar_buku_screen.dart';

class BukuScreen extends StatefulWidget {
  @override
  _BukuScreenState createState() => _BukuScreenState();
}

class _BukuScreenState extends State<BukuScreen> {
  final TextEditingController _kodeBukuController = TextEditingController();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pengarangController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _tahunTerbitController = TextEditingController();

  List<Buku> _bukuList = [];

  void _addBuku() {
    setState(() {
      _bukuList.add(Buku(
        kodeBuku: _kodeBukuController.text,
        judul: _judulController.text,
        pengarang: _pengarangController.text,
        penerbit: _penerbitController.text,
        tahunTerbit: _tahunTerbitController.text,
      ));
    });

    // Clear the controllers
    _kodeBukuController.clear();
    _judulController.clear();
    _pengarangController.clear();
    _penerbitController.clear();
    _tahunTerbitController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buku berhasil ditambahkan')),
    );

    // Navigate to DaftarBukuScreen to display the list of books
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DaftarBukuScreen(bukuList: _bukuList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Buku'),
        backgroundColor: Colors.blueAccent, // University-like color
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title of the form
              Text(
                'Tambah Buku ke Pustaka',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Matching the AppBar color
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Silakan isi data buku baru di bawah ini:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),

              // Kode Buku
              TextField(
                controller: _kodeBukuController,
                decoration: InputDecoration(
                  labelText: 'Kode Buku',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.book),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Judul Buku
              TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul Buku',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.title),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Pengarang
              TextField(
                controller: _pengarangController,
                decoration: InputDecoration(
                  labelText: 'Pengarang',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Penerbit
              TextField(
                controller: _penerbitController,
                decoration: InputDecoration(
                  labelText: 'Penerbit',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.business),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Tahun Terbit
              TextField(
                controller: _tahunTerbitController,
                decoration: InputDecoration(
                  labelText: 'Tahun Terbit',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.calendar_today),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Add Button
              Center(
                child: ElevatedButton(
                  onPressed: _addBuku,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color matching the theme
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Tambah Buku'),
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
