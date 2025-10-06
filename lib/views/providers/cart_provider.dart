import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/cart_item.dart';
import '../../services/auth_service.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  final String apiBaseUrl = "http://10.0.2.2:8000/api";

  CartProvider() {
    _initializeCart();
  }

  /// --- Initialize cart on provider creation ---
  Future<void> _initializeCart() async {
    final loggedIn = await AuthService.isLoggedIn();
    if (loggedIn) {
      try {
        await loadCartFromDb();
      } catch (e) {
        debugPrint("Failed to load cart: $e");
      }
    }
  }

  /// --- Headers with auth token ---
  Future<Map<String, String>> _headers() async {
    final token = await AuthService.getToken(); // your token storage
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// Load cart from backend
  Future<void> loadCartFromDb() async {
    final url = Uri.parse('$apiBaseUrl/cart');
    final response = await http.get(url, headers: await _headers());

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      _items.clear();
      for (var item in data) {
        _items.add(CartItem.fromJson(item));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  /// Add item to cart (backend + local)
  Future<void> addItem(CartItem newItem) async {
    final existingIndex =
        _items.indexWhere((item) => item.menuId == newItem.menuId);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
      await _updateCartItemOnDb(_items[existingIndex]);
    } else {
      _items.add(newItem);
      await _addCartItemToDb(newItem);
    }
    notifyListeners();
  }

  Future<void> removeItem(CartItem item) async {
    _items.remove(item);
    await _removeCartItemFromDb(item);
    notifyListeners();
  }

  Future<void> incrementQuantity(CartItem item) async {
    item.quantity++;
    await _updateCartItemOnDb(item);
    notifyListeners();
  }

  Future<void> decrementQuantity(CartItem item) async {
    if (item.quantity > 1) {
      item.quantity--;
      await _updateCartItemOnDb(item);
    } else {
      await removeItem(item);
    }
    notifyListeners();
  }

  Future<void> clearCart() async {
    _items.clear();
    final url = Uri.parse('$apiBaseUrl/cart/clear');
    await http.delete(url, headers: await _headers());
    notifyListeners();
  }

  /// --- Backend helpers ---
  Future<void> _addCartItemToDb(CartItem item) async {
    final url = Uri.parse('$apiBaseUrl/cart/add');
    await http.post(
      url,
      headers: await _headers(),
      body: jsonEncode({
        'menu_id': item.menuId,
        'quantity': item.quantity,
      }),
    );
  }

  Future<void> _updateCartItemOnDb(CartItem item) async {
    final url = Uri.parse('$apiBaseUrl/cart/update');
    await http.put(
      url,
      headers: await _headers(),
      body: jsonEncode({
        'id': item.id,
        'quantity': item.quantity,
      }),
    );
  }

  Future<void> _removeCartItemFromDb(CartItem item) async {
    final url = Uri.parse('$apiBaseUrl/cart/remove');
    await http.delete(
      url,
      headers: await _headers(),
      body: jsonEncode({'id': item.id}),
    );
  }
}
