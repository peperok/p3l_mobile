import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static int? userId;
  static String? userFullName;
  static String? userEmail;
  static String? userType;       // 'pembeli', 'penitip', 'pegawai'
  static String? userRoleName;   // <- ini yang baru untuk 'kurir', 'hunter', dll
  static String? authToken;

  // Simpan sesi
  static Future<void> saveSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (userId != null) await prefs.setInt('user_id', userId!);
    if (userFullName != null) await prefs.setString('user_full_name', userFullName!);
    if (userEmail != null) await prefs.setString('user_email', userEmail!);
    if (userType != null) await prefs.setString('user_type', userType!);
    if (userRoleName != null) await prefs.setString('user_role_name', userRoleName!); // Tambahkan ini
    if (authToken != null) await prefs.setString('auth_token', authToken!);

    print("Sesi disimpan: userId=$userId, userType=$userType, userRole=$userRoleName");
  }

  // Muat sesi
  static Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    userFullName = prefs.getString('user_full_name');
    userEmail = prefs.getString('user_email');
    userType = prefs.getString('user_type');
    userRoleName = prefs.getString('user_role_name'); // Tambahkan ini
    authToken = prefs.getString('auth_token');

    print("Sesi dimuat: userId=$userId, userType=$userType, userRole=$userRoleName");
  }

  // Hapus sesi
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_full_name');
    await prefs.remove('user_email');
    await prefs.remove('user_type');
    await prefs.remove('user_role_name'); // Tambahkan ini
    await prefs.remove('auth_token');

    userId = null;
    userFullName = null;
    userEmail = null;
    userType = null;
    userRoleName = null;
    authToken = null;

    print("Sesi dibersihkan.");
  }
}
