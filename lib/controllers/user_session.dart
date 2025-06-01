// lib/controllers/user_session.dart (atau di mana pun file ini berada)

import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini

class UserSession {
  static int? userId;
  static String? userFullName;
  static String? userEmail;
  static String? userType; // Akan berisi 'pembeli', 'penitip', 'pegawai'
  static String? authToken; // Jika kamu menyimpan token

  // Fungsi untuk menyimpan sesi ke SharedPreferences
  static Future<void> saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (userId != null) await prefs.setInt('user_id', userId!);
    if (userFullName != null) await prefs.setString('user_full_name', userFullName!);
    if (userEmail != null) await prefs.setString('user_email', userEmail!);
    if (userType != null) await prefs.setString('user_type', userType!);
    if (authToken != null) await prefs.setString('auth_token', authToken!);
    print("Sesi disimpan: userId=${userId}, userType=${userType}"); // Untuk debugging
  }

  // Fungsi untuk memuat sesi dari SharedPreferences (akan berguna untuk login otomatis)
  static Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    userFullName = prefs.getString('user_full_name');
    userEmail = prefs.getString('user_email');
    userType = prefs.getString('user_type');
    authToken = prefs.getString('auth_token');
    print("Sesi dimuat: userId=${userId}, userType=${userType}"); // Untuk debugging
  }

  // Fungsi untuk menghapus sesi dari SharedPreferences
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_full_name');
    await prefs.remove('user_email');
    await prefs.remove('user_type');
    await prefs.remove('auth_token'); // Hapus juga token jika ada
    userId = null;
    userFullName = null;
    userEmail = null;
    userType = null;
    authToken = null;
    print("Sesi dibersihkan."); // Untuk debugging
  }
}