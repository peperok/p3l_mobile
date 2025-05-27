import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart'; // Import constants.dart untuk warna kustom
import 'package:p3lcoba/views/auth/login.dart'; // Sesuaikan path ke login_page.dart
import 'package:p3lcoba/views/auth/register.dart'; // Sesuaikan path ke register_page.dart

class MainUnlogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary, // Menggunakan colorPrimary untuk latar belakang utama
      appBar: AppBar(
        title: Text(
          "Reuse Mart",
          style: TextStyle(color: Colors.white), // Tetap putih untuk teks AppBar
        ),
        backgroundColor: colorSecondary, // Menggunakan colorSecondary untuk AppBar
        automaticallyImplyLeading: false, // Menghilangkan tombol back default
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon aplikasi (bisa sama dengan logo di login page)
              // Image.asset(
              //   'assets/logo.png', // Pastikan path ini benar ke file logo Anda
              //   height: 100,
              //   width: 100,
              //   color: colorSecondary, // Warna logo sama dengan AppBar
              //   // colorBlendMode: BlendMode.srcIn,
              // ),
              // SizedBox(height: 24),
              Text(
                "Selamat Datang di Reuse Mart!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorTertiary, // Menggunakan colorTertiary untuk teks judul
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Temukan barang bekas berkualitas atau jual barang tak terpakai Anda. Jelajahi sekarang atau login untuk pengalaman yang lebih lengkap!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colorTertiary.withOpacity(0.8), // Teks deskripsi dengan opacity
                ),
              ),
              SizedBox(height: 40),
              // Tombol LOGIN SEKARANG
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorAccent, // Warna tombol menggunakan colorAccent
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                ),
                child: Text(
                  "LOGIN SEKARANG",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Link "Belum punya akun? Daftar di sini"
              GestureDetector(
                onTap: () {
                  Navigator.push( // Push agar bisa kembali ke MainUnlogin dari Register
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Belum punya akun? Daftar di sini",
                  style: TextStyle(
                    color: colorAccent, // Warna aksen untuk link
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Jika Anda ingin menonaktifkan "wanna take a look?" dari login_page
              // dan menjadikannya hanya ada di unlogin page (ini sudah diatur di login_page)
              // ...
            ],
          ),
        ),
      ),
    );
  }
}