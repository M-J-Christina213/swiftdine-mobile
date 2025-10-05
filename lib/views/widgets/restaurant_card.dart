import 'package:flutter/material.dart';
import 'package:swiftdine_app/views/widgets/restaurant/restaurant_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Restaurants')),
        body: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: RestaurantListSection(),
        ),
      ),
    );
  }
}

class RestaurantListSection extends StatelessWidget {
  const RestaurantListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          RestaurantCard.restaurants.length,
          (index) => RestaurantCard(index: index),
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final int index;
  final bool compact;

  const RestaurantCard({super.key, required this.index, this.compact = false});

  static final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Mt. Lavinia',
      'image': 'assets/images/mtlavinia.webp',
      'reviews': 4.5,
      'tags': ['Seafood', 'Sri Lankan'],
      'hours': '9 AM - 10 PM',
    },
    {
      'name': 'Kingsbury',
      'image': 'assets/images/kingsbury.jpg',
      'reviews': 4.2,
      'tags': ['Spicy', 'Indian'],
      'hours': '10 AM - 11 PM',
    },
    {
      'name': 'ITC Randeepa',
      'image': 'assets/images/itc.jfif',
      'reviews': 4.7,
      'tags': ['Chicken', 'Chinese'],
      'hours': '8 AM - 9 PM',
    },
    {
      'name': 'Cinnamon Grand',
      'image': 'assets/images/cinamon.jpg',
      'reviews': 4.8,
      'tags': ['Sri Lankan', 'Spicy'],
      'hours': '11 AM - 12 AM',
    },
    {
      'name': 'Taj Samudra',
      'image': 'assets/images/taj.png',
      'reviews': 4.6,
      'tags': ['Seafood', 'Indian'],
      'hours': '9 AM - 10 PM',
    }
  ];

  @override
Widget build(BuildContext context) {
  final restaurant = restaurants[index % restaurants.length];

  return GestureDetector(
    onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RestaurantDetailScreen()),
        );

  },
    child: Container(
      width: compact ? 160 : 240,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Image
          Container(
            height: compact ? 70 : 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(restaurant['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              restaurant['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.orange.shade400, size: compact ? 14 : 16),
                const SizedBox(width: 4),
                Text(
                  restaurant['reviews'].toString(),
                  style: TextStyle(fontSize: compact ? 12 : 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    restaurant['tags'].join(', '),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              'Hours: ${restaurant['hours']}',
              style: TextStyle(
                fontSize: compact ? 10 : 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}