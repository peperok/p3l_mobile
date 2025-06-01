import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user_session.dart'; // Pastikan file ini ada dan diimport

enum UserRole {
  pembeli,
  penitip, // Termasuk penjual
  pegawai,
}

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variabel untuk menyimpan jenis peran pengguna yang dipilih dari UI
  UserRole? selectedRole; 

  // Fungsi untuk mengatur peran pengguna yang dipilih
  void setSelectedRole(UserRole? role) {
    selectedRole = role;
  }

  Future<void> handleLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Email dan password tidak boleh kosong");
      return;
    }

    if (selectedRole == null) {
      _showSnackBar(context, "Pilih jenis akun terlebih dahulu.");
      return;
    }

    String endpoint = '';
    // Tentukan endpoint berdasarkan peran pengguna yang dipilih
    switch (selectedRole) {
      case UserRole.pembeli:
        endpoint = 'loginPembeli';
        break;
      case UserRole.penitip:
        endpoint = 'loginPenitip';
        break;
      case UserRole.pegawai:
        endpoint = 'loginPegawai';
        break;
      default:
        _showSnackBar(context, "Jenis akun tidak valid.");
        return;
    }

    final url = Uri.parse('http://10.0.2.2:8000/api/loginPembeli'); 

    // PENTING: Nama keys di sini harus sama dengan yang diharapkan oleh masing-masing controller di backend.
    // Asumsi: Semua controller backend (PembeliController, PenitipController, PegawaiController)
    // menerima field dengan nama yang sama untuk email dan password.
    // Jika tidak, Anda perlu menyesuaikan 'email_pembeli' dan 'pass_pembeli' berdasarkan 'selectedRole'.
    final body = json.encode({
      'email_pembeli': email,   // Asumsi nama field yang konsisten
      'pass_pembeli': password, // Asumsi nama field yang konsisten
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _showSnackBar(context, data['message']);
        
        // Simpan UserSession: ID, Nama Lengkap, Email, dan TIPE PENGGUNA
        // Pastikan struktur respons backend konsisten (ada 'detail' dengan 'id', 'nama', 'email').
        if (data['detail'] != null) {
          UserSession.userId = data['detail']['id'];
          // Gunakan null-aware operator ?? untuk mencoba beberapa nama field
          UserSession.userFullName = data['detail']['nama_pembeli'] 
                                   ?? data['detail']['nama_penitip'] 
                                   ?? data['detail']['nama_pegawai']
                                   ?? 'Nama Pengguna'; // Default jika tidak ditemukan
          UserSession.userEmail = data['detail']['email_pembeli'] 
                                ?? data['detail']['email_penitip'] 
                                ?? data['detail']['email_pegawai']
                                ?? 'email@example.com'; // Default jika tidak ditemukan
        }
        
        // Simpan TIPE PENGGUNA yang berhasil login
        UserSession.userType = selectedRole.toString().split('.').last; 

        await UserSession.saveSession();

        Navigator.pushReplacementNamed(context, '/home'); 
      } else {
        _showSnackBar(context, data['message'] ?? "Login gagal! Terjadi kesalahan.");
      }
    } catch (e) {
      _showSnackBar(context, "Terjadi kesalahan koneksi. Silakan coba lagi.");
      print("Error login: $e");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}