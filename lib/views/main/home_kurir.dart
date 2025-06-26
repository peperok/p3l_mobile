import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p3lcoba/utils/constants.dart';

class HomeKurir extends StatefulWidget {
  @override
  _HomeKurirState createState() => _HomeKurirState();
}

class _HomeKurirState extends State<HomeKurir> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${message.notification?.title}: ${message.notification?.body}',
          ),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App dibuka dari notifikasi: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Kurir'),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorBackgroundLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Selamat datang, Kurir!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Lihat dan kelola pengantaran barang di bawah ini.'),
            const SizedBox(height: 30),

            // Tombol ke daftar pengantaran
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/list-pengantaran');
            //   },
            //   //child: const Text('Lihat Daftar Pengantaran'),
            // ),
            const SizedBox(height: 15),

            // Tombol ke profil kurir
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/profileKurir');
              },
              icon: const Icon(Icons.person_outline),
              label: const Text('Lihat Profil Kurir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade100,
                foregroundColor: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 15),

            // Tombol ke daftar + riwayat pengiriman
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/daftar-pengiriman');
              },
              icon: const Icon(Icons.list_alt),
              label: const Text('Lihat Daftar & Riwayat Pengiriman'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade100,
                foregroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
