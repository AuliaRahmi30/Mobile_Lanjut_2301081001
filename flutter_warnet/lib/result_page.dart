import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String kodePelanggan;
  final String namaPelanggan;
  final String jenisPelanggan;
  final String tglMasuk;
  final int jamMasuk;
  final int jamKeluar;

  const ResultPage({
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
  });

  @override
  Widget build(BuildContext context) {
    int tarifPerJam = 10000;
    int lama = (jamKeluar - jamMasuk) ~/ 60;
    double diskon = 0;

    if (jenisPelanggan == "VIP" && lama > 2) {
      diskon = 0.02 * tarifPerJam * lama;
    } else if (jenisPelanggan == "GOLD" && lama > 2) {
      diskon = 0.05 * tarifPerJam * lama;
    }

    double totalBayar = (lama * tarifPerJam) - diskon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Perhitungan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pembayaran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            _buildDetailRow('Kode Pelanggan:', kodePelanggan),
            _buildDetailRow('Nama Pelanggan:', namaPelanggan),
            _buildDetailRow('Jenis Pelanggan:', jenisPelanggan),
            _buildDetailRow('Tanggal Masuk:', tglMasuk),
            _buildDetailRow('Jam Masuk:', '${jamMasuk ~/ 60}:${jamMasuk % 60}'),
            _buildDetailRow('Jam Keluar:', '${jamKeluar ~/ 60}:${jamKeluar % 60}'),
            SizedBox(height: 20),
            _buildDetailRow('Lama Waktu:', '$lama jam'),
            _buildDetailRow('Tarif/Jam:', 'Rp$tarifPerJam'),
            _buildDetailRow('Diskon:', 'Rp${diskon.toStringAsFixed(0)}'),
            SizedBox(height: 20),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'Total Bayar: Rp${totalBayar.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
