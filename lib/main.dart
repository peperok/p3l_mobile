import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/auth/register.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/main/homepage.dart'; // Pastikan path ini benar
import 'package:p3lcoba/views/unlogin/main_unlogin.dart'; // Pastikan path ini benar
import 'package:p3lcoba/utils/constants.dart'; // Untuk mengakses warna dan gaya dari constants.dart

void main() {
  runApp(const MyApp()); // runApp adalah titik masuk utama aplikasi Flutter
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
        // textTheme: TextTheme(
        //   bodyLarge: TextStyle(color: colorTertiary),
        //   bodyMedium: TextStyle(color: colorTertiary.withOpacity(0.8)),
        // ),
        // colorScheme: ColorScheme.fromSeed(seedColor: colorAccent), // Jika ingin menggunakan Material 3 ColorScheme
        // dll.
      ),
      initialRoute: '/login', // Rute awal saat aplikasi pertama kali dijalankan
      routes: {
        '/login': (context) => LoginPage(), // Definisi rute untuk halaman Login
        '/register': (context) => RegisterPage(), // Definisi rute untuk halaman Register
        '/home': (context) => HomePage(), // Definisi rute untuk halaman Home
        '/unlogin': (context) => MainUnlogin(), // Definisi rute untuk halaman Unlogin
      },
      // Atau, jika Anda ingin logika untuk memeriksa status login sebelum menentukan halaman awal:
      // home: SplashScreenOrAuthChecker(), // Contoh custom widget yang akan memeriksa status login
    );
  }
}

// Contoh sederhana bagaimana SplashScreenOrAuthChecker bisa terlihat (jika Anda ingin menggunakannya)
// import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini di pubspec.yaml jika dipakai
//
// class SplashScreenOrAuthChecker extends StatefulWidget {
//   const SplashScreenOrAuthChecker({super.key});
//
//   @override
//   State<SplashScreenOrAuthChecker> createState() => _SplashScreenOrAuthCheckerState();
// }
//
// class _SplashScreenOrAuthCheckerState extends State<SplashScreenOrAuthChecker> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }
//
//   void _checkLoginStatus() async {
//     // Simulasi pengecekan status login (misal dari SharedPreferences atau API)
//     await Future.delayed(const Duration(seconds: 2)); // Simulasi loading
//     final prefs = await SharedPreferences.getInstance(); // Contoh menggunakan SharedPreferences
//     final isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Cek status login
//
//     if (isLoggedIn) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       Navigator.pushReplacementNamed(context, '/unlogin'); // Atau '/login' langsung
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorPrimary,
//       body: Center(
//         child: CircularProgressIndicator(color: Colors.white), // Menampilkan loading indicator
//       ),
//     );
//   }
// }