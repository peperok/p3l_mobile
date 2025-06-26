class Kategori {
  final int id;
  final String nama;

  Kategori({
    required this.id,
    required this.nama,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id_kategori'],
      nama: json['nama_kategori'],
    );
  }
}
