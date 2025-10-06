import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/restaurants/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _restaurant = Restaurant.fromJson(data);
      } else {
        throw Exception('Failed to load restaurant');
      }
    } catch (e) {
      ('Error fetching restaurant: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
