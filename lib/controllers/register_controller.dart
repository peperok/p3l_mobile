import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/homepage.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleRegister(BuildContext context) {
    final String name = nameController.text.trim();
    final String phone = phoneController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Validasi sederhana (Anda bisa menambahkan validasi yang lebih kompleks)
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      showPreviewMessage(context, "Mohon lengkapi semua field!");
      return;
    }

    // Simulasi proses registrasi
    // Di aplikasi nyata, Anda akan mengirim data ini ke API backend
    print("Registrasi berhasil:");
    print("Nama: $name");
    print("No Telepon: $phone");
    print("Email: $email");
    print("Password: $password"); // Jangan simpan password plain-text di aplikasi nyata!

    // Setelah registrasi berhasil (simulasi), arahkan ke Homepage
    showPreviewMessage(context, "Registrasi berhasil! Selamat datang, $name.");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    // Kosongkan field setelah registrasi
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}