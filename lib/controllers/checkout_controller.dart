import 'package:flutter/material.dart';

class CheckoutController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Personal Info
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();

  // Card Info
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  // Validate Personal Info
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalController.dispose();
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
  }
}
