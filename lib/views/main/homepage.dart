// Tambahkan import jika belum
import 'package:flutter/material.dart';
import 'package:p3lcoba/models/barang.dart';
import 'package:p3lcoba/models/merch.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart';
import 'package:p3lcoba/controllers/barang_controller.dart';
import 'package:p3lcoba/controllers/merchandise_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p3lcoba/components/informasi_umum_footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Barang>> _futureBarang;
  late Future<List<Merchandise>> _futureMerch;

  final List<String> categories = [
    'Elektronik',
    'Pakaian',
    'Buku',
    'Perabotan',
    'Mainan',
    'Olahraga',
    'Otomotif',
    'Seni',
    'Kecantikan',
    'Lain-lain',
  ];

  @override
  void initState() {
    super.initState();
    _futureMerch = MerchandiseController.getAllMerch();
    _futureBarang = BarangController.getAllBarang();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${message.notification?.title}: ${message.notification?.body}')),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened from notification: ${message.notification?.title}');
    });

    _futureBarang = BarangController.getAllBarang();
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                      ),
                      onSubmitted: (query) {
                        print('Searching for: $query');
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.shopping_cart,
                      color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle,
                      color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Promo Eksklusif untuk Member!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                ),
              ),
            ),

            // Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorTertiary)),
                  const Text('See All',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
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
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(Icons.category, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 5),
                        Text(categories[index],
                            style:
                                TextStyle(fontSize: 12, color: colorTertiary),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Merchandise section
            // ===== Section Merchandise dengan Tombol Lihat Semua =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Merchandise',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/merchandise');
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            FutureBuilder<List<Merchandise>>(
              future: _futureMerch,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Tidak ada merchandise tersedia.'));
                } else {
                  final merchList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: merchList.length,
                      itemBuilder: (context, index) {
                        final merch = merchList[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  merch.imageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported,
                                          size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      merch.namaMerch,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Stok: ${merch.stok}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            // Produk Rekomendasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Rekomendasi untuk Anda',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary)),
            ),
            const SizedBox(height: 16),

            FutureBuilder<List<Barang>>(
              future: _futureBarang,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Tidak ada barang tersedia saat ini.'));
                } else {
                  final barangList = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: barangList.length,
                    itemBuilder: (context, index) {
                      final barang = barangList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BarangDetailPage(barang: barang)));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.network(
                                    barang.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Icon(Icons.broken_image,
                                              size: 50, color: Colors.grey));
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
                                          color: colorTertiary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Rp ${barang.hargaBarang.toStringAsFixed(0)}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colorAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Deskripsi: ${barang.descBarang}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600]),
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

  // ===== Widget builder untuk merchandise
  Widget _buildMerchCard(
      {required String imageUrl, required String name, required int stock}) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                      child: Icon(Icons.broken_image,
                          size: 40, color: Colors.grey));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: colorTertiary)),
                  const SizedBox(height: 4),
                  Text('Stok: $stock',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
            const InformasiUmumFooter(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
