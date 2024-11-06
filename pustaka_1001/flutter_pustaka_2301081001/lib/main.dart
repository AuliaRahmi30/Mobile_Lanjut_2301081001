import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Pustaka Universitas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87), // Menggunakan bodyLarge
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // Menggunakan titleLarge untuk headline
        ),
      ),
      home: HomeScreen(),
    );
  }
}
