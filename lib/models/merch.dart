class Merchandise {
  final int idMerch;
  final String namaMerch;
  final int stok;
  final String imageUrl;

  Merchandise({
    required this.idMerch,
    required this.namaMerch,
    required this.stok,
    this.imageUrl = 'https://via.placeholder.com/150',
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) {
    return Merchandise(
      idMerch: json['id_merch'] as int,
      namaMerch: json['nama_merch'] as String,
      stok: json['stok_merch'] as int,
      imageUrl:
          json['image_url'] as String? ?? 'https://via.placeholder.com/150',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_merch': idMerch,
      'nama_merch': namaMerch,
      'stok_merch': stok,
      'image_url': imageUrl,
    };
  }
}
