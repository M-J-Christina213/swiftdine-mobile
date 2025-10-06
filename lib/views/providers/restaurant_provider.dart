import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  Restaurant? _restaurant;
  bool _isLoading = false;

  Restaurant? get restaurant => _restaurant;
  bool get isLoading => _isLoading;

  Future<void> fetchRestaurant(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("No token found. Please log in again.");
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/restaurants/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _restaurant = Restaurant.fromJson(data);
      } else if (response.statusCode == 401) {
        debugPrint("Unauthorized: Token expired or invalid.");
      } else {
        debugPrint('Failed to load restaurant (Code: ${response.statusCode})');
      }
    } catch (e) {
      debugPrint('Error fetching restaurant: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
