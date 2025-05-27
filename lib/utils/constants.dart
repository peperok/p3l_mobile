import 'package:flutter/material.dart';

// --- Warna Kustom Aplikasi ---
const Color colorPrimary = Color(0xFF937F6A); // Warna utama (coklat muda)
const Color colorSecondary = Color(0xFF5A374B); // Warna kedua (ungu kecoklatan) - untuk AppBar
const Color colorTertiary = Color(0xFF3A4550); // Warna ketiga (biru gelap keabu-abuan) - untuk teks, judul
const Color colorAccent = Color(0xFFB4A95C); // Warna aksen (kuning kehijauan) - untuk tombol, highlight

const Color colorBackgroundLight = Color(0xFFF5EFE1); // Warna latar belakang terang (krem) - untuk body homepage
const Color colorBackgroundDark = Color(0xFF7A6A5C); // Warna latar belakang gelap (coklat tua) - jika diperlukan

// --- Fungsi Umum ---

// Fungsi untuk menampilkan pesan preview
void showPreviewMessage(BuildContext context, String message) { // Menambahkan parameter message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// Fungsi untuk menampilkan popup peralatan (jika masih digunakan)
void showEquipmentPopup(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 120, // Adjust position
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay?.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

// --- Gaya Teks ---

// Gaya teks untuk judul utama (misal di halaman login)
const TextStyle titleTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Gaya teks untuk subjudul (misal di halaman login)
const TextStyle subtitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white70,
);

// Gaya teks untuk tautan (misal "Register here", "wanna take a look?")
const TextStyle linkTextStyle = TextStyle(
  color: Colors.blueAccent, // Tetap menggunakan blueAccent untuk link agar jelas
  decoration: TextDecoration.underline,
);

// Gaya teks untuk judul bagian (misalnya "Category" di homepage, atau judul di halaman lain)
const TextStyle sectionTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: colorTertiary, // Menggunakan warna dari skema baru
);

// Gaya teks untuk isi kartu (digunakan di HomePage untuk teks dalam kartu produk)
const TextStyle cardTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: colorTertiary, // Menggunakan warna dari skema baru
);

// --- Dekorasi Input Field ---

// Dekorasi input field
InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

// --- Gaya Tombol ---

// Gaya tombol utama (misal tombol Login/Register)
final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blueAccent, // Tetap menggunakan blueAccent untuk tombol utama
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
);