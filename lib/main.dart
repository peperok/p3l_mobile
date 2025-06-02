import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/auth/register.dart';
import 'package:p3lcoba/views/main/homepage.dart';
import 'package:p3lcoba/views/unlogin/main_unlogin.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/buyer_profile_page.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'package:p3lcoba/views/main/barang_detail_page.dart'; // <<< Tambahkan ini untuk BarangDetailPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSession.loadSession(); // Muat sesi saat aplikasi dimulai
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reuse Mart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: colorPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: colorSecondary,
          foregroundColor: Colors.white,
        ),
      ),
  
      initialRoute: UserSession.userId != null ? '/home' : '/unlogin', // <<< UBAH INITIAL ROUTE DI SINI
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/unlogin': (context) => MainUnlogin(),
        '/profile': (context) => const BuyerProfilePage(),
        // Meskipun kamu menavigasi ke BarangDetailPage dengan MaterialPageRoute,
        // mendefinisikannya di sini bisa berguna untuk konsistensi atau jika ada
        // skenario lain di mana kamu ingin menavigasi via named route.
        // Namun, jika BarangDetailPage selalu menerima argumen, sebaiknya tetap pakai MaterialPageRoute
        // atau gunakan onGenerateRoute untuk named route dengan argumen.
        // Untuk saat ini, tidak perlu menambahkannya jika kamu selalu pakai MaterialPageRoute.
        // Saya akan tambahkan placeholder di sini kalau-kalau kamu mau eksplorasi nanti.
        // '/barang_detail': (context) => BarangDetailPage(barang: /* perlu argumen */), // Ini akan error tanpa argumen
      },
    );
  }
}