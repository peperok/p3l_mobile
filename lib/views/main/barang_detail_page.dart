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
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Image.network(
                  barang.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.broken_image,
                            size: 100, color: Colors.grey));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barang.namaBarang,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
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
                  const SizedBox(height: 20),

                  // Deskripsi
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deskripsi Barang",
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Garansi
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              color: Colors.grey[600]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              barang.tglGaransi != null
                                  ? "Garansi hingga: ${barang.tglGaransi}"
                                  : "Tidak ada informasi garansi",
                              style: TextStyle(
                                fontSize: 16,
                                color: colorTertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
