import 'package:flutter/material.dart';
import 'pelanggan.dart';

class Warnet {
  final String kodeTransaksi;
  final Pelanggan pelanggan;
  final String jenisPelanggan;
  final DateTime tglMasuk;
  final TimeOfDay jamMasuk;
  final TimeOfDay jamKeluar;
  final double tarif;

  Warnet({
    required this.kodeTransaksi,
    required this.pelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tarif,
  });

  double hitungTotalBayar() {
    int lama = (jamKeluar.hour * 60 + jamKeluar.minute) -
        (jamMasuk.hour * 60 + jamMasuk.minute);
    lama = (lama / 60).ceil(); // Konversi ke jam, bulatkan ke atas

    double diskon = 0;
    if (jenisPelanggan == "VIP" && lama > 2) {
      diskon = 0.02; // Diskon 2%
    } else if (jenisPelanggan == "GOLD" && lama > 2) {
      diskon = 0.05; // Diskon 5%
    }

    return lama * tarif * (1 - diskon);
  }
}