import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:p3lcoba/utils/constants.dart';

class HomeHunter extends StatefulWidget {
  @override
  _HomeHunterState createState() => _HomeHunterState();
}

class _HomeHunterState extends State<HomeHunter> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showPreviewMessage(
        context,
        '${message.notification?.title ?? 'Notifikasi'}: ${message.notification?.body ?? ''}',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App dibuka dari notifikasi: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: AppBar(
        title: const Text(
          'Dashboard Hunter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 80, color: colorAccent),
            const SizedBox(height: 20),
            Text(
              'Selamat Datang, Hunter!',
              style: sectionTitleTextStyle.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Cari dan bantu penitip menemukan barang yang dibutuhkan.',
              style: TextStyle(
                fontSize: 16,
                color: colorTertiary.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Tombol: Lihat Barang Hunter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/barangHunter');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.inventory, color: Colors.white),
                label: const Text(
                  'Lihat Barang Hunter',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol: Lihat Profil Hunter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/profileHunter');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Lihat Profil Hunter',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
