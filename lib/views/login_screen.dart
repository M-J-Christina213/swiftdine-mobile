import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/shared/auth_ui.dart';
import 'package:swiftdine_mobile/views/home_screen.dart';
import 'package:swiftdine_mobile/views/register_scree.dart';

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

  void toggleObscure() => setState(() => obscureText = !obscureText);

  
    void handleLogin() {
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const HomeScreen()),
);
}
  

  @override
  Widget build(BuildContext context) {
    return buildAuthUI(
      context,
      title: 'Login',
      buttonText: 'Login',
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupView()));
      },
    );
  }
}
