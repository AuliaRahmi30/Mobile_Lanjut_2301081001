import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/anggota_page.dart';
import 'pages/buku_page.dart';
import 'pages/peminjaman_page.dart';
import 'pages/pengembalian_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Informasi Pustaka',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/anggota': (context) => const AnggotaPage(),
        '/buku': (context) => const BukuPage(),
        '/peminjaman': (context) => const PeminjamanPage(),
        '/pengembalian': (context) => const PengembalianPage(),
      },
    );
  }
}

