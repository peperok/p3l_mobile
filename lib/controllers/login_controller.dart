import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Import UserSession
import 'user_session.dart'; // Pastikan file ini ada dan diimport

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleLogin(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Email and password must not be empty");
      return;
    }

    final url = Uri.parse('https://darksalmon-oyster-681673.hostingersite.com/api/login'); // Update with your Laravel backend URL
    final body = json.encode({'email': email, 'password': password});

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-Type': 'application/json'},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _showSnackBar(context, data['message']);
        
        // Simpan user_id ke UserSession agar bisa diakses dari mana saja
        if (data['user'] != null && data['user']['id'] != null) {
          UserSession.userId = data['user']['id'];
        }
        
        // Simpan userFullName juga, pastikan API mengembalikan 'full_name'
        if (data['user'] != null && data['user']['full_name'] != null) {
          UserSession.userFullName = data['user']['full_name'].toString();
        }

        if (data['user'] != null && data['user']['email'] != null) {
          UserSession.userEmail = data['user']['email'].toString();
        }

        Navigator.pushReplacementNamed(context, '/home'); // Navigate to home page
      } else {
        _showSnackBar(context, data['message']);
      }
    } catch (e) {
      _showSnackBar(context, "An error occurred. Please try again.");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
