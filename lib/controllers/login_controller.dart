import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'user_session.dart';

enum UserRole {
  pembeli,
  penitip,
  pegawai,
}

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  UserRole? selectedRole;

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

    final url = Uri.parse('http://10.0.2.2:8000/api/$endpoint');

    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _showSnackBar(context, data['message']);

        if (data['detail'] != null) {
          UserSession.userId = data['detail']['id'];
          UserSession.userFullName = data['detail']['nama_pembeli'] ??
              data['detail']['nama_penitip'] ??
              data['detail']['nama_pegawai'] ??
              'Nama Pengguna';
          UserSession.userEmail =
              data['detail']['email'] ?? 'email@example.com';
          UserSession.userType = selectedRole.toString().split('.').last;

          if (selectedRole == UserRole.pegawai) {
            final jabatan = data['detail']['jabatan'];
            if (jabatan != null) {
              UserSession.userRoleName = jabatan.toString().toLowerCase();
            }
          }

          await UserSession.saveSession();
        }

        // FCM Token
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          await http.post(
            Uri.parse('http://10.0.2.2:8000/api/fcm-token'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'id': UserSession.userId,
              'role': UserSession.userType,
              'token': fcmToken,
            }),
          );
        }

        // Routing
        if (selectedRole == UserRole.pegawai) {
          final role = UserSession.userRoleName;
          if (role == 'kurir') {
            Navigator.pushReplacementNamed(context, '/homeKurir');
          } else if (role == 'hunter') {
            Navigator.pushReplacementNamed(context, '/homeHunter');
          } else {
            _showSnackBar(context, "Role pegawai tidak dikenali. Akses ditolak.");
          }
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        try {
          final data = json.decode(response.body);
          _showSnackBar(context, data['message'] ?? "Login gagal.");
        } catch (e) {
          _showSnackBar(context, "Login gagal: format respons tidak dikenali.");
          print("Gagal parsing response: $e");
          print("Isi body: ${response.body}");
        }
      }
    } catch (e) {
      _showSnackBar(context, "Terjadi kesalahan koneksi. Silakan coba lagi.");
      print("Error login: $e");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
