class Buku {
  final String id;
  final String judul;
  final String pengarang;
  final String penerbit;
  final String tahunTerbit;
  final String image;
  final String? deskripsi;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
    required this.image,
    this.deskripsi,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'].toString(),
      judul: json['judul'],
      pengarang: json['pengarang'],
      penerbit: json['penerbit'],
      tahunTerbit: json['tahun_terbit'],
      image: json['image'] ?? '',
      deskripsi: json['deskripsi'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'pengarang': pengarang,
      'penerbit': penerbit,
      'tahun_terbit': tahunTerbit,
      'image': image,
      'deskripsi': deskripsi,
    };
  }
} 