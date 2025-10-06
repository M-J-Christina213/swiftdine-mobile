import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/themes/app_theme.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    

    // Simulate loading, then navigate to HomeScreen after 3 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/home');

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/swiftdine.jpg',
              width: 500,
              height: 200,
            ),
            
            
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: AppTheme.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
