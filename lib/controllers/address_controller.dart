import 'package:flutter/material.dart';

class AddressController {
  final districtController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final laneController = TextEditingController();
  final postalCodeController = TextEditingController();

  void dispose() {
    districtController.dispose();
    provinceController.dispose();
    cityController.dispose();
    laneController.dispose();
    postalCodeController.dispose();
  }
}
