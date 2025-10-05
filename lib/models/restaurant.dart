// models/restaurant.dart

import 'menu_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final String address;
  final double rating;
  final String description;
  final List<String> categories;
  final List<MenuItem> menu;
  final List<String> galleryImages;
  final List<Map<String, dynamic>> reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.rating,
    required this.description,
    required this.categories,
    required this.menu,
    required this.galleryImages,
    required this.reviews,
  });
}
