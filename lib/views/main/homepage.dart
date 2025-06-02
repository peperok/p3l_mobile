import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p3lcoba/models/barang.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Barang>> _futureBarang;

  // Contoh data untuk kategori (masih dummy, bisa dihubungkan ke backend nanti)
  final List<String> categories = [
    'Elektronik', 'Pakaian', 'Buku', 'Perabotan', 'Mainan',
    'Olahraga', 'Otomotif', 'Seni', 'Kecantikan', 'Lain-lain',
  ];

  @override
  void initState() {
    super.initState();
    _futureBarang = _fetchBarang();
  }

  Future<List<Barang>> _fetchBarang() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/barang'); // URL backend kamu

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
      print('Error fetching barang for homepage: $e');
      throw Exception('Gagal terhubung ke server atau memuat produk: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight, // Menggunakan warna latar belakang terang untuk body
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // Tinggi AppBar yang lebih besar
        child: AppBar(
          backgroundColor: colorSecondary, // Warna AppBar atas
          elevation: 0, // Hilangkan shadow
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container( // Ini TextField yang fungsional (untuk search)
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField( // Ini bisa jadi TextField yang sebenarnya
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          ),
                          onSubmitted: (query) {
                            // Aksi search untuk user yang sudah login
                            print('Logged-in user searching for: $query');
                            // Implementasi search API call di sini
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                      onPressed: () {
                        // Aksi shopping cart untuk user yang sudah login
                        print('Logged-in user shopping cart pressed');
                        // Navigasi ke halaman keranjang
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle, color: Colors.white, size: 28),
                      onPressed: () {
                        // Navigasi ke halaman profil (sudah ada)
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Jarak antara search bar dan banner
                const SizedBox(height: 0), // Placeholder, bisa jadi banner di bawah search bar
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Besar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Warna placeholder untuk banner
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(image: AssetImage('assets/banner.png'), fit: BoxFit.cover,), // Tambahkan gambar banner
                ),
                child: Center(
                  child: Text(
                    'Promo Eksklusif untuk Member!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Bagian Kategori
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
                    onTap: () {
                      // Aksi "See All" untuk kategori (user sudah login)
                      print('Logged-in user See All Categories pressed');
                      // Navigasi ke halaman semua kategori
                    },
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
            // Daftar Kategori yang bisa di-scroll horizontal
            SizedBox(
              height: 100, // Tinggi untuk daftar kategori
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        // Aksi ketika kategori diklik (user sudah login)
                        print('Logged-in user clicked category: ${categories[index]}');
                        // Navigasi ke halaman daftar produk berdasarkan kategori
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Warna placeholder untuk ikon kategori
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.category, color: Colors.grey[700]), // Contoh ikon
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

            // Judul Bagian Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Rekomendasi untuk Anda",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorTertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid produk yang diambil dari backend (FutureBuilder)
            FutureBuilder<List<Barang>>(
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
                        style: const TextStyle(color: Colors.red),
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
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final barang = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          // User sudah login, jadi navigasi langsung ke detail barang
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarangDetailPage(barang: barang),
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
                                    barang.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
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
                                      barang.namaBarang,
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
                                      "Rp ${barang.hargaBarang.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colorAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Deskripsi: ${barang.descBarang}",
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