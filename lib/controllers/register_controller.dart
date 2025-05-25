import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String dob = dobController.text.trim();
    String address = addressController.text.trim();

    final url = Uri.parse('https://darksalmon-oyster-681673.hostingersite.com/api/register');
    final body = json.encode({
      'full_name': fullName,
      'email': email,
      'password': password,
      'dob': dob,
      'address': address,
    });

    // Menampilkan loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      Navigator.of(context).pop(); // Menutup loading indicator

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _showSnackBar(context, data['message']);
        // Menggunakan rootNavigator untuk memastikan navigasi berjalan dengan benar
        Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login'); // Navigasi ke halaman login
      } else if (response.statusCode == 422) {
        final errors = json.decode(response.body)['message'];
        if (errors is Map) {
          String errorMessages = "";
          errors.forEach((field, messages) {
            errorMessages += "$field: ${messages.join(", ")}\n";
          });
          _showSnackBar(context, errorMessages.trim());
        } else {
          _showSnackBar(context, errors ?? "Validation error occurred.");
        }
      } else {
        _showSnackBar(context, "Unexpected error occurred. Status: ${response.statusCode}");
      }
    } catch (e) {
      Navigator.of(context).pop(); // Menutup loading indicator jika terjadi error
      print("Error: $e");
      _showSnackBar(context, "An error occurred. Please check your connection and try again.");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey[600],
      ),
    );
  }
}
