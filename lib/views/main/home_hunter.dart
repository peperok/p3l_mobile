// lib/views/home_hunter.dart
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeHunter extends StatefulWidget {
  @override
  _HomeHunterState createState() => _HomeHunterState();
}

class _HomeHunterState extends State<HomeHunter> {
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
        title: Text('Dashboard Hunter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Selamat datang, Hunter!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Cari dan kelola barang untuk penitipan.'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/barang-hunter');
              },
              child: Text('Lihat Barang Hunter'),
            ),
          ],
        ),
      ),
    );
  }
}