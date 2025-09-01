import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/home_screen.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureText = true;

  void toggleObscure() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void handleSignup() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }


    Navigator.pushReplacement(
     context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Create your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: toggleObscure,
                ),
              ),
              obscureText: obscureText,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: obscureText,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: handleSignup,
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
