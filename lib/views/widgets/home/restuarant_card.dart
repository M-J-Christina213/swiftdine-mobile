import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/views/widgets/restaurants/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  final int restaurantId;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String location;
  final bool compact;

  const RestaurantCard({
    super.key,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.location,
    this.compact = false,
  });

  factory RestaurantCard.fromJson(Map<String, dynamic> json, {bool compact = false}) {
    // Replace host IP with emulator-friendly IP
    String imageUrl = json['image_path'] != null
        ? 'http://10.0.2.2:8000/storage/${json['image_path']}' // emulator fix
        : 'assets/images/placeholder.png'; // local fallback

    return RestaurantCard(
      restaurantId: json['id'],
      name: json['name'] ?? 'Unknown',
      image: imageUrl,
      rating: (json['rating'] != null)
          ? double.tryParse(json['rating'].toString()) ?? 0.0
          : 0.0,
      cuisine: json['cuisine'] ?? 'N/A',
      location: json['location'] ?? 'N/A',
      compact: compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantDetailScreen(
            restaurantId: restaurantId,
          ),
        ),
      ),
      child: Container(
        width: compact ? 160 : 240,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Restaurant image
            Container(
              height: compact ? 70 : 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                        size: compact ? 30 : 50,
                        color: Colors.grey.shade400,
                      ),
                    );
                  },
                ),
              ),
            ),

            // 🏠 Restaurant name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ⭐ Rating & cuisine
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange.shade400,
                    size: compact ? 14 : 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: TextStyle(fontSize: compact ? 12 : 14),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cuisine,
                      style: TextStyle(
                        fontSize: compact ? 10 : 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // 📍 Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                location,
                style: TextStyle(
                  fontSize: compact ? 10 : 12,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
