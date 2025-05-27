import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart'; // Import warna kustom
import 'package:p3lcoba/models/product.dart'; // Import model produk

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Contoh data untuk kategori (Anda bisa menggantinya dengan data dari API)
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

  // Contoh data untuk produk (Anda bisa menggantinya dengan data dari API)
  final List<Product> products = [
    Product(id: '1', name: 'Laptop Bekas', imageUrl: 'assets/placeholder_product.png', price: 3500000),
    Product(id: '2', name: 'Kemeja Batik', imageUrl: 'assets/placeholder_product.png', price: 75000),
    Product(id: '3', name: 'Novel Fiksi', imageUrl: 'assets/placeholder_product.png', price: 40000),
    Product(id: '4', name: 'Meja Belajar', imageUrl: 'assets/placeholder_product.png', price: 200000),
    Product(id: '5', name: 'Action Figure', imageUrl: 'assets/placeholder_product.png', price: 150000),
    Product(id: '6', name: 'Raket Badminton', imageUrl: 'assets/placeholder_product.png', price: 120000),
    Product(id: '7', name: 'Ban Mobil', imageUrl: 'assets/placeholder_product.png', price: 500000),
    Product(id: '8', name: 'Lukisan Abstrak', imageUrl: 'assets/placeholder_product.png', price: 300000),
  ];

  // Tambahkan path untuk gambar placeholder di pubspec.yaml Anda
  // flutter:
  //   assets:
  //     - assets/placeholder_banner.png
  //     - assets/placeholder_product.png

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight, // Warna latar belakang terang untuk body
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0), // Tinggi AppBar yang lebih besar
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
                    // Search bar
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
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          ),
                          onSubmitted: (query) {
                            // Implementasi search logic
                            print('Searching for: $query');
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Shopping Cart Icon
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                      onPressed: () {
                        // Aksi ketika tombol cart ditekan
                        print('Shopping cart pressed');
                      },
                    ),
                    // Profile Icon
                    IconButton(
                      icon: Icon(Icons.account_circle, color: Colors.white, size: 28),
                      onPressed: () {
                        // Aksi ketika tombol profile ditekan
                        print('Profile icon pressed');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10), // Jarak antara search bar dan banner
                // Area untuk banner atau promo (sesuai gambar)
                Container(
                  height: 0, // Placeholder, akan ditambahkan nanti jika ada banner di bawah search bar
                  // color: Colors.white, // Contoh warna placeholder
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
            // Banner Besar (sesuai gambar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                height: 180, // Tinggi banner
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Warna placeholder untuk banner
                  borderRadius: BorderRadius.circular(10),
                  // Anda bisa menambahkan image di sini:
                  // image: DecorationImage(
                  //   image: AssetImage('assets/placeholder_banner.png'),
                  //   fit: BoxFit.cover,
                  // ),
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
            SizedBox(height: 10),
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
                      print('See All Categories');
                      // Aksi ketika "See All" ditekan, navigasi ke halaman kategori lengkap
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent, // Menggunakan warna default Flutter untuk link
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Daftar Kategori yang bisa di-scroll horizontal
            Container(
              height: 100, // Tinggi untuk daftar kategori
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                            color: Colors.grey[300], // Warna placeholder untuk ikon kategori
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.category, color: Colors.grey[700]), // Contoh ikon
                        ),
                        SizedBox(height: 5),
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
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Grid produk yang dijual
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true, // Agar GridView mengambil tinggi sesuai kontennya
                physics: NeverScrollableScrollPhysics(), // Agar GridView tidak bisa discroll sendiri
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kolom
                  crossAxisSpacing: 10.0, // Jarak antar kolom
                  mainAxisSpacing: 10.0, // Jarak antar baris
                  childAspectRatio: 0.75, // Rasio lebar/tinggi item
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        print('Product ${product.name} tapped');
                        // Aksi ketika produk ditekan, navigasi ke halaman detail produk
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200], // Placeholder gambar produk
                                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                // Anda bisa menambahkan image di sini:
                                // image: DecorationImage(
                                //   image: AssetImage(product.imageUrl),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: Center(
                                child: Icon(Icons.image, size: 50, color: Colors.grey[500]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: colorTertiary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Rp ${product.price.toInt().toStringAsFixed(0)}', // Format harga
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
              ),
            ),
            SizedBox(height: 20), // Padding di bagian bawah
          ],
        ),
      ),
    );
  }
}