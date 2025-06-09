import 'package:flutter/material.dart';
import 'package:p3lcoba/models/barang.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/controllers/user_session.dart'; // <<< Import UserSession

class BarangDetailPage extends StatelessWidget {
  final Barang barang;

  const BarangDetailPage({super.key, required this.barang});

  // Fungsi helper untuk menampilkan SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Fungsi helper untuk navigasi ke login
  void _navigateToLogin(BuildContext context) {
    _showSnackBar(context, "Anda harus login untuk melakukan aksi ini!");
    Navigator.pushNamed(context, '/login'); // Arahkan ke halaman login
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah user sudah login atau belum
    final bool isLoggedIn = UserSession.userId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          barang.namaBarang,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.network(
                barang.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                      child: Icon(Icons.broken_image,
                          size: 100, color: Colors.grey));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barang.namaBarang,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Rp ${barang.hargaBarang.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorAccent,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Deskripsi Barang:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    barang.descBarang,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorTertiary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Informasi Garansi:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        barang.tglGaransi != null
                            // &&barang.tglGaransi!.isNotEmpty
                            ? "Garansi hingga: ${barang.tglGaransi}"
                            : "Tidak ada informasi garansi",
                        style: TextStyle(
                          fontSize: 16,
                          color: colorTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Aksi (Add to Cart / Buy Now)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Cek apakah user sudah login
                            if (isLoggedIn) {
                              // User sudah login, lakukan aksi tambahkan ke keranjang
                              _showSnackBar(context,
                                  '"${barang.namaBarang}" ditambahkan ke keranjang!');
                              // Tambahkan logic Add to Cart ke backend di sini
                            } else {
                              // User belum login, arahkan ke halaman login
                              _navigateToLogin(context);
                            }
                          },
                          icon: const Icon(Icons.shopping_cart_outlined,
                              color: Colors.white),
                          label: const Text("Tambah ke Keranjang",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Cek apakah user sudah login
                            if (isLoggedIn) {
                              // User sudah login, lakukan aksi beli sekarang
                              _showSnackBar(context,
                                  'Membeli "${barang.namaBarang}" sekarang!');
                              // Tambahkan logic Buy Now ke backend di sini
                            } else {
                              // User belum login, arahkan ke halaman login
                              _navigateToLogin(context);
                            }
                          },
                          icon: const Icon(Icons.payment, color: Colors.white),
                          label: const Text("Beli Sekarang",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorAccent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
