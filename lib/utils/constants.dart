import 'package:flutter/material.dart';

// Warna utama aplikasi
const Color colorPrimary = Color(0xFF282A41);

// Fungsi untuk menampilkan pesan preview
void showPreviewMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("This is a preview of the app!")),
  );
}

// Gaya teks untuk judul utama
const TextStyle titleTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Gaya teks untuk subjudul
const TextStyle subtitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white70,
);

// Gaya teks untuk tautan
const TextStyle linkTextStyle = TextStyle(
  color: Colors.blueAccent,
  decoration: TextDecoration.underline,
);

// Gaya teks untuk judul bagian (solid putih, misalnya "Sports Class", "Personal Trainer")
const TextStyle sectionTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

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

// Gaya tombol utama
final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.blueAccent,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
);

// Gaya teks untuk isi kartu (digunakan di HomePage untuk teks dalam kartu)
const TextStyle cardTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: colorPrimary,
);

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

