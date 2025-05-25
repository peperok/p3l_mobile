import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/controllers/register_controller.dart';
import '../unlogin/main_unlogin.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _controller = RegisterController();

  RegisterPage({Key? key}) : super(key: key); // Constructor dengan Key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView( // Prevent overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Spacing
              // Title
              Text("Reuse Mart", style: titleTextStyle),
              SizedBox(height: 8),
              Text("Let’s get started", style: subtitleTextStyle),
              SizedBox(height: 32),
              // Input fields
              TextField(
                controller: _controller.fullNameController,
                decoration: inputDecoration("Full Name"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller.emailController,
                decoration: inputDecoration("Email"),
                keyboardType: TextInputType.emailAddress, // Email keyboard
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller.passwordController,
                obscureText: true,
                decoration: inputDecoration("Password"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller.dobController,
                readOnly: true,
                decoration: inputDecoration("Date of Birth"),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    _controller.dobController.text = formattedDate;
                  }
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: _controller.addressController,
                decoration: inputDecoration("Address"),
              ),
              SizedBox(height: 32),
              // Register button
              ElevatedButton(
                onPressed: () {
                  _handleRegister(context);
                },
                style: primaryButtonStyle,
                child: Text(
                  "REGISTER",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or", style: TextStyle(color: Colors.white70)),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text("Already have an account? Login", style: linkTextStyle),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainUnlogin()),
                  );
                },
                child: Text(
                  "wanna take a look?",
                  style: TextStyle(
                      color: Colors.white70, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle register button press with validations
  void _handleRegister(BuildContext context) {
    String fullName = _controller.fullNameController.text.trim();
    String email = _controller.emailController.text.trim();
    String password = _controller.passwordController.text.trim();
    String dob = _controller.dobController.text.trim();
    String address = _controller.addressController.text.trim();

    // Validasi apakah semua field sudah diisi
    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        dob.isEmpty ||
        address.isEmpty) {
      _showSnackBar(context, "All fields must be filled!");
      return;
    }

    // Validasi panjang password
    if (password.length < 6) {
      _showSnackBar(context, "Password must be at least 6 characters!");
      return;
    }

    // Jika validasi lolos, tampilkan dialog konfirmasi
    _showConfirmationDialog(context);
  }

  // SnackBar untuk menampilkan pesan error
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // Confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Changed parameter name to avoid confusion
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are your data correct?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Kembali ke halaman register
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                _controller.registerUser(context); // Panggil controller untuk registrasi
              },
            ),
          ],
        );
      },
    );
  }
}
