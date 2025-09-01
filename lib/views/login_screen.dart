// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swiftdine_mobile/shared/auth_ui.dart';
import 'package:swiftdine_mobile/views/home_screen.dart';
import 'package:swiftdine_mobile/views/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  bool rememberMe = false;
  bool isLoading = false;

  void toggleObscure() => setState(() => obscureText = !obscureText);

  // API URL
  final String apiUrl = "http://10.0.2.2:8000/api/login";

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        // Navigate to HomeScreen if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        // Show error message from API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login failed')),
        );
      }
    } else {
      // Server error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error, please try again later')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildAuthUI(
      context,
      title: 'Login',
      buttonText: isLoading ? 'Logging in...' : 'Login',
      onSubmit: handleLogin,
      emailController: emailController,
      passwordController: passwordController,
      obscureText: obscureText,
      toggleObscure: toggleObscure,
      rememberMe: rememberMe,
      onRememberChanged: (val) => setState(() => rememberMe = val ?? false),
      footerText: "Don't have an account?",
      footerActionText: 'Sign up',
      onFooterAction: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignupView()),
        );
      },
    );
  }
}
