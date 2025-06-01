import 'package:flutter/material.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/controllers/register_controller.dart';
import 'package:p3lcoba/views/auth/login.dart';
import '../unlogin/main_unlogin.dart'; // Pastikan path ini benar

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
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            Column(
              children: [
                Text(
                  "Daftar Akun Baru",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorTertiary,
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorBackgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form( // Bungkus dengan Form widget
                  key: _controller.formKey, // Kaitkan GlobalKey dengan Form
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
                      TextFormField( // Ganti TextField menjadi TextFormField
                        controller: _controller.nameController,
                        validator: _controller.validateName, // Panggil fungsi validasi dari controller
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
                          errorStyle: TextStyle(color: Colors.red[700]), // Styling untuk teks error
                        ),
                        style: TextStyle(color: colorTertiary),
                      ),
                      SizedBox(height: 15),
                      // Input No Telephone
                      TextFormField( // Ganti TextField menjadi TextFormField
                        controller: _controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: _controller.validatePhone, // Panggil fungsi validasi dari controller
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
                          errorStyle: TextStyle(color: Colors.red[700]), // Styling untuk teks error
                        ),
                        style: TextStyle(color: colorTertiary),
                      ),
                      SizedBox(height: 15),
                      // Input Email
                      TextFormField( // Ganti TextField menjadi TextFormField
                        controller: _controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _controller.validateEmail, // Panggil fungsi validasi dari controller
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
                          errorStyle: TextStyle(color: Colors.red[700]), // Styling untuk teks error
                        ),
                        style: TextStyle(color: colorTertiary),
                      ),
                      SizedBox(height: 15),
                      // Input Password
                      TextFormField( // Ganti TextField menjadi TextFormField
                        controller: _controller.passwordController,
                        obscureText: _obscureText,
                        validator: _controller.validatePassword, // Panggil fungsi validasi dari controller
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
                          errorStyle: TextStyle(color: Colors.red[700]), // Styling untuk teks error
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
                            backgroundColor: colorAccent,
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: colorAccent,
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
            ),
          ],
        ),
      ),
    );
  }
}