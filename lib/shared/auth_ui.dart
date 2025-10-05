// shared/auth_ui.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildAuthUI(
  BuildContext context, {
  required String title,
  required String buttonText,
  required VoidCallback onSubmit,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required bool obscureText,
  required VoidCallback toggleObscure,
  required bool rememberMe,
  required ValueChanged<bool?>? onRememberChanged,
  required String footerText,
  required String footerActionText,
  required VoidCallback onFooterAction,
  // optional controllers for signup
  TextEditingController? fullNameController,
  TextEditingController? phoneController,
  TextEditingController? confirmPasswordController,
}) {
  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/ac/0f/85/salle-du-restaurant-soir.jpg?w=900&h=500&s=1',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          ),
        ),
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.4))),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Swift Dine',
                    style: GoogleFonts.pacifico(
                      fontSize: 32,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Experience the Flavors of Sri Lanka',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Full Name field (optional)
                  if (fullNameController != null)
                    Column(
                      children: [
                        TextField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  // Phone Number field (optional)
                  if (phoneController != null)
                    Column(
                      children: [
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  // Email
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: toggleObscure,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Confirm Password (optional)
                  if (confirmPasswordController != null)
                    Column(
                      children: [
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: obscureText,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  if (onRememberChanged != null)
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: onRememberChanged,
                        ),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: onFooterAction,
                    child: Text.rich(
                      TextSpan(
                        text: '$footerText ',
                        children: [
                          TextSpan(
                            text: footerActionText,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '© 2025 Swift Dine. All rights reserved.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
