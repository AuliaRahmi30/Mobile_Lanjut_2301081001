import 'package:flutter/material.dart';
import '../models/buku.dart';

class DaftarBukuScreen extends StatelessWidget {
  final List<Buku> bukuList;

  DaftarBukuScreen({required this.bukuList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku Pustaka'),
        backgroundColor: Colors.blueAccent, // University-like color
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title of the screen
            Text(
              'Daftar Buku Pustaka Teknologi Informasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // List of books
            Expanded(
              child: ListView.builder(
                itemCount: bukuList.length,
                itemBuilder: (context, index) {
                  final buku = bukuList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        buku.judul,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${buku.pengarang} - ${buku.penerbit}',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        buku.kodeBuku,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
