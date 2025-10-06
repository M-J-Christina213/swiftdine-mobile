// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swiftdine_mobile/shared/auth_ui.dart';
import 'package:swiftdine_mobile/views/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  if (data.containsKey('token')) {
    final token = data['token'];

     // Save token locally
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);

  Navigator.pushReplacementNamed(context, '/home');
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login failed: No token received')),
  );
}

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
