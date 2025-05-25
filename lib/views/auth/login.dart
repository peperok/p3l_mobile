import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/login_controller.dart';
import 'package:p3lcoba/utils/constants.dart'; // Import constants.dart untuk showPreviewMessage dan colorPrimary
import '../unlogin/main_unlogin.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary, // Menggunakan warna dari constants.dart
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text(
              "Reuse Mart",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            // Sub-judul Please, Log In
            Text(
              "Please, Log In",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 32),
            // Input Email
            TextField(
              controller: _controller.emailController,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Input Password
            TextField(
              controller: _controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 32),
            // Tombol Login
            ElevatedButton(
              onPressed: () {
                _controller.handleLogin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Ganti primary ke backgroundColor
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            // Divider dengan teks "or"
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white24,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "or",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white24,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Tautan ke Register Page
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "Don’t have an account yet? Register here",
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 40),
            // Link tambahan
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
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
