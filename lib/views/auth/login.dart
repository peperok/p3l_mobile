import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/login_controller.dart';
import 'package:p3lcoba/utils/constants.dart'; // Import constants.dart untuk showPreviewMessage dan colorPrimary
import '../unlogin/main_unlogin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();
  bool _obscureText = true; // State untuk toggle visibility password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary, // Menggunakan colorPrimary untuk latar belakang utama
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            // Bagian atas: Icon, Hello, Welcome
            Column(
              children: [
                // Icon Keranjang / Logo Aplikasi
                
          
                Text(
                  "Hello!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorTertiary, // Menggunakan colorTertiary untuk teks gelap
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Welcome to ReuseMart",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorTertiary.withOpacity(0.7), // Sedikit opacity untuk teks sekunder
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Card Login
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorBackgroundLight, // Menggunakan colorBackgroundLight untuk card login
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
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorTertiary, // Menggunakan colorTertiary
                      ),
                    ),
                    SizedBox(height: 25),
                    // Input Email
                    TextField(
                      controller: _controller.emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white, // Tetap putih untuk input field
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]), // Warna hint text
                      ),
                      style: TextStyle(color: colorTertiary), // Warna teks input
                    ),
                    SizedBox(height: 15),
                    // Input Password
                    TextField(
                      controller: _controller.passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white, // Tetap putih untuk input field
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]), // Warna hint text
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600], // Warna ikon visibility
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      style: TextStyle(color: colorTertiary), // Warna teks input
                    ),
                    SizedBox(height: 10),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          print('Forgot Password?');
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: colorTertiary.withOpacity(0.7), // Warna teks link
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.handleLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorAccent, // Menggunakan colorAccent untuk tombol login
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Divider "or login with"
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: colorTertiary.withOpacity(0.4), // Warna divider
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "or login with",
                            style: TextStyle(color: colorTertiary.withOpacity(0.8), fontSize: 16), // Warna teks
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: colorTertiary.withOpacity(0.4), // Warna divider
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    // Tombol Social Media
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // Facebook Button
                    //     InkWell(
                    //       onTap: () {
                    //         print('Login with Facebook');
                    //       },
                    //       child: Container(
                    //         width: 50,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.2),
                    //               spreadRadius: 2,
                    //               blurRadius: 5,
                    //               offset: Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Center(
                    //           child: Icon(Icons.facebook, color: Colors.blue[800], size: 30), // Facebook icon often uses its own blue
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 25),
                    //     // Google Button
                    //     InkWell(
                    //       onTap: () {
                    //         print('Login with Google');
                    //       },
                    //       child: Container(
                    //         width: 50,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.2),
                    //               spreadRadius: 2,
                    //               blurRadius: 5,
                    //               offset: Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Center(
                    //           child: Image.asset('assets/google.png', height: 28), // Path ke logo Google
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 50),
                    // Don't Have account? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have account?",
                          style: TextStyle(color: colorTertiary.withOpacity(0.7), fontSize: 15),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: colorAccent, // Menggunakan colorAccent untuk link Register
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Link "wanna take a look?"
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainUnlogin()),
                          );
                        },
                        child: Text(
                          "wanna take a look?",
                          style: TextStyle(
                            color: colorAccent, // Menggunakan colorAccent
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
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