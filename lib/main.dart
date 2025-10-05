import 'package:flutter/material.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift Dine',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const LoginScreen(),
    );
  }
}
