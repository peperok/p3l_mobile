import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http
import 'dart:convert'; // Import json
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/models/barang.dart'; // Import model Barang
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart';

import 'package:p3lcoba/components/informasi_umum_footer.dart';


class MainUnlogin extends StatefulWidget {
  @override
  _MainUnloginState createState() => _MainUnloginState();
}

class _MainUnloginState extends State<MainUnlogin> {
  // Contoh data untuk kategori (ini masih dummy, bisa dihubungkan ke backend nanti)
  final List<String> categories = [
    'Elektronik', 'Pakaian', 'Buku', 'Perabotan', 'Mainan',
    'Olahraga', 'Otomotif', 'Seni', 'Kecantikan', 'Lain-lain',
  ];

  late Future<List<Barang>> _futureBarang; // Future untuk menampung data barang

  @override
  void initState() {
    super.initState();
    _futureBarang = _fetchBarang(); // Panggil fungsi untuk mengambil data barang
  }

  // Fungsi untuk mengambil data barang dari backend
  Future<List<Barang>> _fetchBarang() async {
    // <<< PENTING: Ganti dengan URL backend lokalmu (atau IP Hostinger jika sudah deploy) >>>
    // Jika emulator Android: http://10.0.2.2:8000
    // Jika HP Fisik: http://IP_KOMPUTER_KAMU:8000
    final url = Uri.parse('http://10.0.2.2:8000/api/barang'); // Contoh untuk Android Emulator

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['data'] is List) {
          List<dynamic> barangJson = responseBody['data'];
          return barangJson.map((json) => Barang.fromJson(json)).toList();
        } else {
          throw Exception('Data is not a list in API response: ${responseBody['data']}');
        }
      } else {
        throw Exception('Failed to load barang: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching barang for unlogin page: $e');
      throw Exception('Gagal terhubung ke server atau memuat produk: $e');
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: colorSecondary,
          elevation: 0,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _navigateToLogin,
                        child: AbsorbPointer(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                      onPressed: _navigateToLogin,
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
                      onPressed: _navigateToLogin,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 0),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: GestureDetector(
                onTap: _navigateToLogin,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Promo Hari Ini!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: _navigateToLogin,
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.category, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: colorTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Grid produk yang diambil dari backend
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List<Barang>>( // Menggunakan FutureBuilder
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final barang = snapshot.data![index];
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Tetap bisa melihat detail barang tanpa login
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BarangDetailPage(barang: barang),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(barang.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: barang.imageUrl.isEmpty // Fallback for empty image URL
                                        ? Center(child: Icon(Icons.image, size: 50, color: Colors.grey[500]))
                                        : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        barang.namaBarang,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: colorTertiary,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rp ${barang.hargaBarang.toInt().toStringAsFixed(0)}',
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
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
            ),
            const InformasiUmumFooter(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}