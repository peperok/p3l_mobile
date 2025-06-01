import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/auth/register.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/main/homepage.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/unlogin/main_unlogin.dart'; 
import 'package:p3lcoba/utils/constants.dart'; 
import 'package:p3lcoba/views/main/buyer_profile_page.dart';
import 'package:p3lcoba/controllers/user_session.dart';

void main() async { // Ubah menjadi async
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter diinisialisasi
  await UserSession.loadSession(); // Muat sesi saat aplikasi dimulai
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { // MyApp adalah root widget aplikasi Anda
  const MyApp({super.key}); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) { // build method untuk membangun UI
    return MaterialApp( // MaterialApp adalah widget dasar untuk aplikasi Material Design
      title: 'Reuse Mart App', // Judul aplikasi
      theme: ThemeData( // Tema aplikasi
        primarySwatch: Colors.blue, // Warna swatch utama (bisa diatur custom)
        // Anda bisa mengatur theme secara global di sini, contoh:
        scaffoldBackgroundColor: colorPrimary, // Menggunakan warna dari constants
        appBarTheme: AppBarTheme(
          backgroundColor: colorSecondary, // Menggunakan warna dari constants
          foregroundColor: Colors.white, // Warna teks dan ikon di AppBar
        ),
        
      ),
      initialRoute: '/login', // Rute awal saat aplikasi pertama kali dijalankan
      routes: {
        '/login': (context) => LoginPage(), // Definisi rute untuk halaman Login
        '/register': (context) => RegisterPage(), // Definisi rute untuk halaman Register
        '/home': (context) => HomePage(), // Definisi rute untuk halaman Home
        '/unlogin': (context) => MainUnlogin(), 
        '/profile': (context) => const BuyerProfilePage(),
      },
      
    );
  }
}
