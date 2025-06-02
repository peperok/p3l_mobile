// lib/views/main/homepage.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p3lcoba/models/barang.dart'; // <<< Import model Barang
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart'; // <<< Import halaman detail barang

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Barang>> _futureBarang; // Menggunakan Future<List<Barang>>

  @override
  void initState() {
    super.initState();
    _futureBarang = _fetchBarang(); // Panggil fungsi fetch barang
  }

  Future<List<Barang>> _fetchBarang() async {
    // <<< Pastikan URL ini benar untuk endpoint BARANG di Laravelmu >>>
    final url = Uri.parse('http://10.0.2.2:8000/api/barang'); // Contoh: untuk Android Emulator

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        // Perhatikan 'data' key di respons backend kamu
        if (responseBody['data'] is List) {
          List<dynamic> barangJson = responseBody['data'];
          return barangJson.map((json) => Barang.fromJson(json)).toList();
        } else {
          throw Exception('Data is not a list: ${responseBody['data']}');
        }
      } else {
        throw Exception('Failed to load barang: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching barang: $e');
      throw Exception('Gagal terhubung ke server atau memuat barang: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reuse Mart", style: TextStyle(color: Colors.white)),
        backgroundColor: colorPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              print('Search icon pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
            onPressed: () {
              print('Shopping cart icon pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: colorPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Produk Daur Ulang & Bekas Berkualitas",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Temukan barang unik dan bantu lingkungan!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Jelajahi Produk Kami",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorTertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            FutureBuilder<List<Barang>>( // Menggunakan FutureBuilder untuk Barang
              future: _futureBarang,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Tidak ada barang tersedia saat ini.'),
                    ),
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final barang = snapshot.data![index]; // Ambil objek barang
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarangDetailPage(barang: barang), // Navigasi ke BarangDetailPage
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  child: Image.network(
                                    barang.imageUrl, // Menggunakan imageUrl dari model Barang
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      barang.namaBarang, // Menggunakan namaBarang
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: colorTertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Rp ${barang.hargaBarang.toStringAsFixed(0)}", // Menggunakan hargaBarang
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colorAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Deskripsi: ${barang.descBarang}", // Menggunakan descBarang
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}