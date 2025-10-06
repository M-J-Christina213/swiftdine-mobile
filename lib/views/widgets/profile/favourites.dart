import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> mainMeals = [
    {
      'name': 'Polos Curry',
      'description': 'Spicy young jackfruit curry served hot.',
      'reviews': '4.5 (150 reviews)',
      'restaurant': 'Lanka Spice House',
      'image': 'assets/images/polos.jpg',
    },
    {
      'name': 'Kaju Curry',
      'description': 'Creamy cashew nut curry with Sri Lankan spices.',
      'reviews': '4.8 (230 reviews)',
      'restaurant': 'Ceylon Delights',
      'image': 'assets/images/kaju.jpeg',
    },
    {
      'name': 'Fried Rice',
      'description': 'Fried rice with vegetables and egg, served with chili paste.',
      'reviews': '4.6 (310 reviews)',
      'restaurant': 'Rice & Curry Spot',
      'image': 'assets/images/friedrice.jpg',
    },
  ];

  List<Map<String, dynamic>> desserts = [
    {
      'name': 'Watalappan',
      'description': 'Rich jaggery and coconut milk pudding with spices.',
      'reviews': '4.9 (190 reviews)',
      'restaurant': 'Sweet Lanka',
      'image': 'assets/images/watalappan.jpg',
    },
    {
      'name': 'Curd & Treacle',
      'description': 'Buffalo curd served with sweet kithul treacle.',
      'reviews': '4.7 (250 reviews)',
      'restaurant': 'Tradition Bowl',
      'image': 'assets/images/curd.webp',
    },
  ];

  void removeFromFavorites(Map<String, dynamic> item, bool isMainMeal) {
    setState(() {
      if (isMainMeal) {
        mainMeals.remove(item);
      } else {
        desserts.remove(item);
      }
    });
  }

      Widget buildFoodCard(Map<String, dynamic> item, bool isMainMeal) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item['image'],
              width: 100,    
              height: 200,   
              fit: BoxFit.cover,
            ),
          ),
          title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['description']),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16), // Gold star
                  const SizedBox(width: 4),
                  Text(item['reviews'], style: const TextStyle(color: Colors.grey)),
                ],
              ),
              Text(
                'Restaurant: ${item['restaurant']}',
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () => removeFromFavorites(item, isMainMeal),
          ),
          isThreeLine: true,
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Main Meals / Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (mainMeals.isEmpty)
              const Text("No main meals in favorites."),
            ...mainMeals.map((meal) => buildFoodCard(meal, true)),
            const SizedBox(height: 20),
            const Text("Desserts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (desserts.isEmpty)
              const Text("No desserts in favorites."),
            ...desserts.map((dessert) => buildFoodCard(dessert, false)),
          ],
        ),
      ),
    );
  }
}
