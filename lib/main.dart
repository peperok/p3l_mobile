import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/auth/register.dart';
import 'package:p3lcoba/views/main/homepage.dart';
import 'package:p3lcoba/views/unlogin/main_unlogin.dart';
import 'package:p3lcoba/utils/constants.dart';
import 'package:p3lcoba/views/main/buyer_profile_page.dart';
import 'package:p3lcoba/views/main/hunter_profile.dart';
import 'package:p3lcoba/controllers/user_session.dart';
import 'dart:convert';
import 'package:p3lcoba/views/main/home_hunter.dart';
import 'package:p3lcoba/views/main/home_kurir.dart';
import 'package:p3lcoba/views/main/merchandise.dart';
import 'package:p3lcoba/views/main/penitip_profile_page.dart';
import 'package:p3lcoba/views/main/kurir_profile_page.dart';
import 'package:p3lcoba/views/main/top_seller_page.dart';

// import firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inisialisasi notifikasi lokal
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_stat_notification');

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
    // TODO: kirim fcmToken ke backend
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional notification permission');
  } else {
    print('User declined or has not accepted notification permission');
  }

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print('A new getInitialMessage event was published!');
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification!.title} / ${message.notification!.body}');

      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
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
        '/profilePembeli': (context) => const BuyerProfilePage(),
        '/profilePenitip': (context) => const PenitipProfilePage(),
        '/profileKurir': (context) => const KurirProfilePage(),
        '/profileHunter':(context) => const HunterProfilePage(),
        '/merchandise': (context) => const MerchandisePage(),
        '/top-sellers': (context) => TopSellerPage(),
      },
    );
  }
}

// Fungsi routing awal berdasarkan role user
String _getInitialRoute() {
  if (UserSession.userId != null) {
    if (UserSession.userType == 'pegawai') {
      if (UserSession.userRoleName == 'kurir') {
        return '/homeKurir';
      } else if (UserSession.userRoleName == 'hunter') {
        return '/homeHunter';
      } else {
        return '/home'; // pegawai lain
      }
    } else if (UserSession.userType == 'pembeli') {
      return '/profilePembeli';
    } else if (UserSession.userType == 'penitip') {
      return '/profilePenitip';
    }else if (UserSession.userType == 'hunter') {
      return '/profileHunter';
    } else {
      return '/home'; // fallback
    }
  } else {
    return '/unlogin';
  }
}
