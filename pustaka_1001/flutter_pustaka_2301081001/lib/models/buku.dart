class Buku {
  final String kodeBuku;
  final String judul;
  final String pengarang;
  final String penerbit;
  final String tahunTerbit;

  Buku({
    required this.kodeBuku,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
  });

  // Fungsi untuk mengonversi objek ke Map
  Map<String, String> toMap() {
    return {
      'kodeBuku': kodeBuku,
      'judul': judul,
      'pengarang': pengarang,
      'penerbit': penerbit,
      'tahunTerbit': tahunTerbit,
    };
  }
}
