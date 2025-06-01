import 'package:flutter/material.dart';
import 'package:p3lcoba/controllers/login_controller.dart';
import 'package:p3lcoba/utils/constants.dart';
import '../unlogin/main_unlogin.dart'; // Pastikan path ini benar

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = LoginController();
  bool _obscureText = true;

  // Default atau pilihan awal untuk Dropdown
  UserRole? _selectedLoginUserRole = UserRole.pembeli; 

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan peran default saat pertama kali UI dimuat
    _controller.setSelectedRole(_selectedLoginUserRole);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Column(
              children: [
                // Icon Keranjang / Logo Aplikasi
                const Text(
                  "Hello!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colorTertiary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Welcome to ReuseMart",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorTertiary.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: colorBackgroundLight,
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
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorTertiary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // --- Dropdown untuk Memilih Tipe Akun ---
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<UserRole>(
                          isExpanded: true,
                          value: _selectedLoginUserRole,
                          hint: const Text("Pilih Jenis Akun"),
                          onChanged: (UserRole? newValue) {
                            setState(() {
                              _selectedLoginUserRole = newValue;
                              _controller.setSelectedRole(newValue); // Set tipe di controller
                            });
                          },
                          items: const <DropdownMenuItem<UserRole>>[
                            DropdownMenuItem<UserRole>(
                              value: UserRole.pembeli,
                              child: Text("Pembeli"),
                            ),
                            DropdownMenuItem<UserRole>(
                              value: UserRole.penitip,
                              child: Text("Penitip/Penjual"),
                            ),
                            DropdownMenuItem<UserRole>(
                              value: UserRole.pegawai,
                              child: Text("Pegawai"),
                            ),
                          ],
                          icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                          style: TextStyle(color: colorTertiary, fontSize: 16),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // --- Akhir Dropdown ---

                    // Input Email
                    TextField(
                      controller: _controller.emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(color: colorTertiary),
                    ),
                    const SizedBox(height: 15),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                    const SizedBox(height: 10),
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
                            color: colorTertiary.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.handleLogin(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Divider "or login with"
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: colorTertiary.withOpacity(0.4),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "or login with",
                            style: TextStyle(color: colorTertiary.withOpacity(0.8), fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: colorTertiary.withOpacity(0.4),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Don't Have account? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have account?",
                          style: TextStyle(color: colorTertiary.withOpacity(0.7), fontSize: 15),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: colorAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                            color: colorAccent,
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