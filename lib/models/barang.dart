class Barang {
  final int idBarang; // id_barang
  final String namaBarang; // nama_barang
  final String? tglGaransi; // tgl_garansi (nullable)
  final double hargaBarang; // harga_barang
  final String descBarang; // desc_barang
  // Asumsi ada kolom image_url di database, jika tidak ada ini akan error saat parsing
  // Jika tidak ada kolom image_url, gunakan placeholder atau tanyakan cara penyimpanan gambar
  final String imageUrl; // Tambahkan ini sebagai placeholder sementara

  Barang({
    required this.idBarang,
    required this.namaBarang,
    this.tglGaransi, // Nullable
    required this.hargaBarang,
    required this.descBarang,
    this.imageUrl = 'https://via.placeholder.com/150', // Default placeholder jika tidak ada gambar
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    // Pastikan nama key cocok dengan respons JSON dari backend
    return Barang(
      idBarang: json['id_barang'] as int,
      namaBarang: json['nama_barang'] as String,
      tglGaransi: json['tgl_garansi'] as String?, // Bisa null
      hargaBarang: (json['harga_barang'] as num).toDouble(), // Pastikan bisa handle int atau double
      descBarang: json['desc_barang'] as String,
      // Jika backend punya kolom untuk gambar, sesuaikan key di sini. Contoh: json['gambar_url']
      // Jika tidak ada, imageUrl akan menggunakan default placeholder
      imageUrl: json['image_url'] as String? ?? 'https://via.placeholder.com/150', // Fallback to placeholder
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_barang': idBarang,
      'nama_barang': namaBarang,
      'tgl_garansi': tglGaransi,
      'harga_barang': hargaBarang,
      'desc_barang': descBarang,
      'image_url': imageUrl,
    };
  }
}