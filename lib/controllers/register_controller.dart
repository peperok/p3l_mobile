import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p3lcoba/utils/constants.dart'; // Pastikan ini diimport jika digunakan untuk colors/snackbar
import 'package:p3lcoba/views/main/homepage.dart'; // Akan dinavigasi ke '/login' setelah sukses

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Nama tidak boleh kosong!";
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Nomor telepon tidak boleh kosong!";
    if (value.length != 12 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Nomor telepon harus 12 digit angka!";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email tidak boleh kosong!";
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9._%+-]+@(gmail|yahoo|outlook|hotmail|aol|protonmail)\.com$");
    if (!emailRegex.hasMatch(value)) {
      return "Format email tidak valid (contoh: user@gmail.com).";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password tidak boleh kosong!";
    if (value.length < 8) return "Password minimal 8 karakter!";
    return null;
  }

  Future<void> handleRegister(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      final String name = nameController.text.trim();
      final String phone = phoneController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Endpoint register hanya untuk Pembeli
      final url = Uri.parse('http://10.0.2.2:8000/api/registerPembeli');
      
      // Nama keys harus sesuai dengan yang diharapkan oleh PembeliController di backend
      final body = json.encode({
        'nama_pembeli': name,
        'tlpn_pembeli': phone,
        'email_pembeli': email,
        'pass_pembeli': password,
      });

      try {
        final response = await http.post(
          url,
          body: body,
          headers: {'Content-Type': 'application/json'},
        );

        final data = json.decode(response.body);

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

       if (response.statusCode == 200 || response.statusCode == 201) {
          _showSnackBar(context, data['message'] ?? "Registrasi berhasil!");
          Navigator.pushReplacementNamed(context, '/login'); 
        } else {
          String errorMessage;
          // Periksa apakah 'message' adalah String atau Map
          if (data['message'] is String) {
            errorMessage = data['message'];
          } else if (data['message'] is Map) {
            // Ini asumsi jika 'message' adalah Map, kita ambil nilai pertama dari Map tersebut
            // Ini mencoba menangani kasus seperti: {"email_pembeli": ["The email has been taken."]}
            Map<String, dynamic> errorDetails = data['message'];
            if (errorDetails.isNotEmpty) {
              errorMessage = (errorDetails.values.first is List) 
                             ? (errorDetails.values.first as List).first.toString() 
                             : errorDetails.values.first.toString();
            } else {
              errorMessage = "Registrasi gagal! Detail error tidak tersedia.";
            }
          } else if (data['errors'] is Map) { // Jika Laravel mengembalikan 'errors' terpisah
            Map<String, dynamic> errors = data['errors'];
            if (errors.isNotEmpty) {
                errorMessage = (errors.values.first is List) 
                               ? (errors.values.first as List).first.toString() 
                               : errors.values.first.toString();
            } else {
                errorMessage = "Registrasi gagal! Detail error tidak tersedia.";
            }
          }
          else {
            errorMessage = "Registrasi gagal! Terjadi kesalahan tak terduga.";
          }
          _showSnackBar(context, errorMessage);
        }
      } catch (e) {
        _showSnackBar(context, "Terjadi kesalahan koneksi. Silakan coba lagi.");
        print("Error registrasi: $e"); // Ini penting untuk melihat error koneksi
      }
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
    } else {
      _showSnackBar(context, "Registrasi gagal! Pastikan semua form sudah terisi dengan benar.");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}