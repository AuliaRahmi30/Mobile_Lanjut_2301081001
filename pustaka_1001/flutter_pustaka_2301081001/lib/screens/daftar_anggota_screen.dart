import 'package:flutter/material.dart';
import '../models/anggota.dart';

class DaftarAnggotaScreen extends StatelessWidget {
  final List<Anggota> anggotaList;

  DaftarAnggotaScreen({required this.anggotaList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota Pustaka'),
        backgroundColor: Colors.blueAccent, // University-like color
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title of the screen
            Text(
              'Anggota Pustaka Teknologi Informasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // List of members
            Expanded(
              child: ListView.builder(
                itemCount: anggotaList.length,
                itemBuilder: (context, index) {
                  final anggota = anggotaList[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        anggota.namaAnggota,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        anggota.alamat,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        anggota.kodeAnggota,
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
