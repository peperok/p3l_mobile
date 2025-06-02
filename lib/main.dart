import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/auth/register.dart';
import 'package:p3lcoba/views/main/homepage.dart';
import 'package:p3lcoba/views/unlogin/main_unlogin.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/buyer_profile_page.dart';
import 'package:p3lcoba/controllers/user_session.dart';
// import 'package:p3lcoba/views/main/barang_detail_page.dart'; // Tidak perlu diimpor langsung jika hanya digunakan via MaterialPageRoute

// <<< IMPORT UNTUK FIREBASE >>>
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart'; // File yang di-generate oleh `flutterfire configure`

// <<< FUNGSI GLOBAL UNTUK BACKGROUND MESSAGE HANDLER >>>
// Ini HARUS di luar fungsi main() dan bersifat global
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Pastikan Firebase sudah diinisialisasi untuk background message
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
  // Kamu bisa menambahkan logika di sini untuk memproses pesan background
  // Misalnya, menyimpan ke database lokal, menampilkan notifikasi lokal, dll.
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // <<< INISIALISASI FIREBASE >>>
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // <<< LOGIC PENGAMBILAN FCM TOKEN & PERMISSION >>>
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Minta izin notifikasi dari user (penting untuk iOS dan Android 13+)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted notification permission');
    // Dapatkan FCM token perangkat ini
    String? fcmToken = await messaging.getToken();
    print("FCM Token perangkat ini: $fcmToken");

    // Di sini kamu perlu mengirim fcmToken ini ke backend Laravel-mu
    // dan menyimpannya di database terkait user yang login.
    // Ini biasanya dilakukan saat user login atau jika token berubah.
    // Contoh: UserSession.sendFcmTokenToBackend(fcmToken); // Kamu perlu implementasi fungsi ini
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional notification permission');
  } else {
    print('User declined or has not accepted notification permission');
  }

  // --- Handling messages (initial/foreground/background) ---
  // Untuk notifikasi ketika aplikasi dibuka dari terminated state (benar-benar ditutup)
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print('A new getInitialMessage event was published!');
      // Contoh: Navigasi ke halaman tertentu jika notifikasi diklik
      // Navigator.pushNamed(context, '/notification_detail', arguments: message);
    }
  });

  // Untuk notifikasi ketika aplikasi di foreground (sedang dibuka)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification!.title} / ${message.notification!.body}');
      // Karena FCM tidak menampilkan notifikasi otomatis saat app di foreground,
      // kamu perlu menggunakan paket seperti `flutter_local_notifications` untuk menampilkannya.
    }
  });

  // Untuk notifikasi ketika aplikasi di background (tapi tidak terminated)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // <<< AKHIR LOGIC FIREBASE >>>

  await UserSession.loadSession(); // Muat sesi setelah Firebase diinisialisasi
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
      initialRoute: UserSession.userId != null ? '/home' : '/unlogin',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/unlogin': (context) => MainUnlogin(),
        '/profile': (context) => const BuyerProfilePage(),
        // BarangDetailPage tidak perlu di routes karena di-pass objek langsung
        // '/barang_detail': (context) => BarangDetailPage(),
      },
    );
  }
}