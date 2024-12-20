class Peminjaman {
  final String id;
  final String idAnggota;
  final String idBuku;
  final String tanggalPinjam;
  final String tanggalKembali;

  Peminjaman({
    required this.id,
    required this.idAnggota,
    required this.idBuku,
    required this.tanggalPinjam,
    required this.tanggalKembali,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'].toString(),
      idAnggota: json['id_anggota'].toString(),
      idBuku: json['id_buku'].toString(),
      tanggalPinjam: json['tanggal_pinjam'],
      tanggalKembali: json['tanggal_kembali'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_anggota': idAnggota,
      'id_buku': idBuku,
      'tanggal_pinjam': tanggalPinjam,
      'tanggal_kembali': tanggalKembali,
    };
  }
} 