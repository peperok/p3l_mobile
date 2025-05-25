import 'package:flutter/material.dart';
import 'package:p3lcoba/views/auth/login.dart';
import 'package:p3lcoba/views/auth/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reuse Mart',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        //'/home': (context) => HomePage(),
      },
    );
  }
}
