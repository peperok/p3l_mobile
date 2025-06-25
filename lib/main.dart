import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/auth/register.dart';
import 'package:p3lcoba/views/main/homepage.dart';
import 'package:p3lcoba/views/unlogin/main_unlogin.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/buyer_profile_page.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'dart:convert';
import 'package:p3lcoba/views/main/home_hunter.dart';
import 'package:p3lcoba/views/main/home_kurir.dart';
import 'package:p3lcoba/views/main/merchandisePage.dart';
import 'package:p3lcoba/views/main/hunter_profile.dart';

//import firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Instansiasi FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Fungsi global untuk background message handler (tetap sama)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // <<< INISIALISASI FLUTTER LOCAL NOTIFICATIONS >>>
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_stat_notification');
  // Untuk iOS, kamu perlu konfigurasi tambahan jika target iOS
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(); // Untuk iOS/macOS
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // <<< AKHIR INISIALISASI FLUTTER LOCAL NOTIFICATIONS >>>

  FirebaseMessaging messaging = FirebaseMessaging.instance;

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
    String? fcmToken = await messaging.getToken();
    print("FCM Token perangkat ini: $fcmToken");
    // TODO: Kirim fcmToken ini ke backend Laravel-mu
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional notification permission');
  } else {
    print('User declined or has not accepted notification permission');
  }

  // --- Handling messages ---
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print('A new getInitialMessage event was published!');
    }
  });

  // <<< INI BAGIAN UTAMA UNTUK MENAMPILKAN NOTIFIKASI DI FOREGROUND >>>
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification!.title} / ${message.notification!.body}');

      // Tampilkan notifikasi lokal menggunakan flutter_local_notifications
      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode, // ID notifikasi unik
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // Harus sama dengan channel_id di AndroidManifest.xml
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
          iOS: DarwinNotificationDetails(), // Untuk iOS
        ),
        payload: jsonEncode(
            message.data), // Data yang bisa kamu ambil saat notif diklik
      );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await UserSession.loadSession();
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
      initialRoute: _getInitialRoute(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/homeKurir': (context) => HomeKurir(),
        '/homeHunter': (context) => HomeHunter(),
        '/unlogin': (context) => MainUnlogin(),
        '/profile': (context) => const BuyerProfilePage(),
        '/merchandise': (context) => MerchandisePage(),
        '/profileHunter': (context) => HunterProfilePage(),
      },
    );
  }
}

String _getInitialRoute() {
  if (UserSession.userId != null) {
    if (UserSession.userType == 'pegawai') {
      if (UserSession.userRoleName == 'kurir') {
        return '/homeKurir';
      } else if (UserSession.userRoleName == 'hunter') {
        return '/homeHunter';
      } else {
        return '/home'; // fallback kalau pegawai lain
      }
    } else {
      return '/home'; // pembeli / penitip
    }
  } else {
    return '/unlogin';
  }
}
