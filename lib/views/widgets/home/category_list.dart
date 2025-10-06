import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<dynamic> categories = [];
  bool isLoading = true;

  final String apiUrl = "http://10.0.2.2:8000/api/categories"; 

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      ("Error fetching categories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // You can map emojis or icons to categories for UI fun 😄
  String getEmoji(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'sri lankan special':
        return '🍛';
      case 'seafood dishes':
        return '🦐';
      case 'chicken dishes':
        return '🍗';
      case 'spicy dishes':
        return '🌶️';
      case 'indian':
        return '🍲';
      case 'chinese':
        return '🥡';
      case 'thai':
        return '🍜';
      case 'desserts':
        return '🍰';
      case 'beverages':
        return '🥤';
      default:
        return '🍽️';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categories.isEmpty) {
      return const Center(child: Text("No categories found"));
    }

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final name = category['name'] ?? 'Unknown';

          return GestureDetector(
            onTap: () {
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected Category: $name')),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getEmoji(name),
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
