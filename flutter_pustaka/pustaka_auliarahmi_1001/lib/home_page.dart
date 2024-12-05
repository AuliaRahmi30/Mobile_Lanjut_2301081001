import 'package:flutter/material.dart';
import 'package:pustaka_auliarahmi_1001/pages/home_pengembalian.dart';
import 'package:pustaka_auliarahmi_1001/pages/home_anggota.dart';
import 'package:pustaka_auliarahmi_1001/pages/home_buku.dart';
import 'package:pustaka_auliarahmi_1001/pages/home_peminjaman.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Menu"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 101, 67, 33),
              ),
              child: Text(
                'Menu Utama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Anggota'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageAnggota()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Buku'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageBuku()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Peminjaman'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePagePeminjaman()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_return), 
              title: Text('Pengembalian'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePagePengembalian()),
                );
              },
            ),
            Divider(), 
          ],
        ),
      ),
      body: Center(
        child: Text(
          'SELAMAT DATANG DI SISTEM INFORMASI PUSTAKA!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}