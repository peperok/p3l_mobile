import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/controllers/register_controller.dart';
import 'package:p3lcoba/views/auth/login.dart';
import '../unlogin/main_unlogin.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _controller = RegisterController();
  bool _obscureText = true; // State untuk toggle visibility password

  @override
  void dispose() {
    _controller.dispose(); // Pastikan controller di-dispose saat widget tidak lagi digunakan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary, // Latar belakang utama menggunakan colorPrimary
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80), // Jarak dari atas
            // Bagian atas: (Opsional: Anda bisa menambahkan logo di sini juga jika mau)
            Column(
              children: [
                // Anda bisa menambahkan logo di sini jika ingin ada di register page juga
                // Image.asset(
                //   'assets/logo.png', // Pastikan path ini benar
                //   height: 80,
                //   width: 80,
                //   color: colorSecondary,
                // ),
                // SizedBox(height: 20),
                Text(
                  "Daftar Akun Baru", // Atau "Register" sesuai gambar
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorTertiary, // Warna teks judul
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Bergabunglah dengan ReuseMart",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorTertiary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Card Register
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorBackgroundLight, // Warna latar belakang krem terang untuk card
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorTertiary,
                      ),
                    ),
                    SizedBox(height: 25),
                    // Input Nama
                    TextField(
                      controller: _controller.nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: colorTertiary),
                    ),
                    SizedBox(height: 15),
                    // Input No Telephone
                    TextField(
                      controller: _controller.phoneController,
                      keyboardType: TextInputType.phone, // Keyboard khusus nomor telepon
                      decoration: InputDecoration(
                        hintText: "No Telephone",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: colorTertiary),
                    ),
                    SizedBox(height: 15),
                    // Input Email
                    TextField(
                      controller: _controller.emailController,
                      keyboardType: TextInputType.emailAddress, // Keyboard khusus email
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: colorTertiary),
                    ),
                    SizedBox(height: 15),
                    // Input Password
                    TextField(
                      controller: _controller.passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      style: TextStyle(color: colorTertiary),
                    ),
                    SizedBox(height: 30),
                    // Tombol Register
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.handleRegister(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorAccent, // Warna oranye/aksen
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Sudah punya akun? Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: colorTertiary.withOpacity(0.7), fontSize: 15),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement( // Gunakan pushReplacement agar tidak bisa kembali ke register
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: colorAccent, // Warna aksen untuk link Login
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}