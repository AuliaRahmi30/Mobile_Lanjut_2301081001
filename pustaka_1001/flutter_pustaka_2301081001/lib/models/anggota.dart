class Anggota {
  final String kodeAnggota;
  final String namaAnggota;
  final String alamat;
  final String jenisKelamin;

  Anggota({
    required this.kodeAnggota,
    required this.namaAnggota,
    required this.alamat,
    required this.jenisKelamin,
  });

  // Fungsi untuk mengonversi objek ke Map
  Map<String, String> toMap() {
    return {
      'kodeAnggota': kodeAnggota,
      'namaAnggota': namaAnggota,
      'alamat': alamat,
      'jenisKelamin': jenisKelamin,
    };
  }
}
