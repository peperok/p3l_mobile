import 'package:flutter/material.dart';
import 'package:p3lcoba/models/barang.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart';
import 'package:p3lcoba/controllers/barang_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p3lcoba/components/informasi_umum_footer.dart';

class HomePenitip extends StatefulWidget {
  const HomePenitip({super.key});

  @override
  State<HomePenitip> createState() => _HomePenitipState();
}

class _HomePenitipState extends State<HomePenitip> {
  late Future<List<Barang>> _futureBarang;

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
      appBar: AppBar(
        title: const Text("Dashboard Penitip",
            style: TextStyle(color: Colors.white)),
        backgroundColor: colorSecondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Barang Titipan Anda',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorTertiary)),
            ),
            FutureBuilder<List<Barang>>(
              future: _futureBarang,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada barang titipan.'));
                } else {
                  final barangList = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: barangList.length,
                    itemBuilder: (context, index) {
                      final barang = barangList[index];
                      return ListTile(
                        leading: Image.network(
                          barang.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                        title: Text(barang.namaBarang),
                        subtitle:
                            Text("Rp ${barang.hargaBarang.toStringAsFixed(0)}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BarangDetailPage(barang: barang),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: InformasiUmumFooter(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
