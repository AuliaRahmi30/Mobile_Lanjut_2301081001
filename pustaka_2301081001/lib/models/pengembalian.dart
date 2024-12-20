class Pengembalian {
  final String id;
  final String idPeminjaman;
  final String tanggalKembali;
  final String denda;

  Pengembalian({
    required this.id,
    required this.idPeminjaman,
    required this.tanggalKembali,
    required this.denda,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'].toString(),
      idPeminjaman: json['id_peminjaman'].toString(),
      tanggalKembali: json['tanggal_kembali'],
      denda: json['denda'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_peminjaman': idPeminjaman,
      'tanggal_kembali': tanggalKembali,
      'denda': denda,
    };
  }
} 