import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/views/widgets/restaurants/category_menu_screen.dart';
import 'package:swiftdine_mobile/views/cart_screen.dart';
import '../themes/app_theme.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  final List<Map<String, String>> meals = const [
    {'icon': '☀️', 'label': 'Breakfast'},
    {'icon': '🍛', 'label': 'Lunch'},
    {'icon': '🍝', 'label': 'Dinner'},
  ];

  final List<Map<String, String>> modes = const [
    {'icon': '🪑', 'title': 'Dine-In', 'desc': 'Reserve a table'},
    {'icon': '🛵', 'title': 'Delivery', 'desc': 'To your door'},
    {'icon': '🥡', 'title': 'Takeaway', 'desc': 'Pick up & go'},
  ];

final List<Map<String, String>> categories = const [
  {'title': 'Sri Lankan Special', 'image': 'assets/images/srilankan.png'},
  {'title': 'Seafood Dishes', 'image': 'assets/images/seafood.png'},
  {'title': 'Chicken Dishes', 'image': 'assets/images/chicken.png'},
  {'title': 'Spicy Dishes', 'image': 'assets/images/spicy.png'},
  {'title': 'Indian', 'image': 'assets/images/indian.png'},
  {'title': 'Chinese', 'image': 'assets/images/chinese.png'},
  {'title': 'Thai', 'image': 'assets/images/thai.png'},
  {'title': 'Desserts', 'image': 'assets/images/dessert.png'},
  {'title': 'Beverages', 'image': 'assets/images/beverages.jpg'},
];
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menus"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
            
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner with background, meals & mode cards
            Stack(
              children: [
                Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://miro.medium.com/v2/resize:fit:1400/0*OuSIEprF8jIzBc4g"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(height: 320, color: Colors.black45),
                SizedBox(
                  height: 320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Craving Something Delicious?",
                          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
                      const SizedBox(height: 12),

                      // Meals buttons (Breakfast, Lunch, Dinner)
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: meals.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, i) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Text(meals[i]['icon']!, style: const TextStyle(fontSize: 16, color: Colors.white)),
                                const SizedBox(width: 8),
                                Text(meals[i]['label']!,
                                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Mode Cards inside banner (without buttons)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: modes.map((m) {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(m['icon']!, style: const TextStyle(fontSize: 28, color: Colors.white)),
                                    const SizedBox(height: 6),
                                    Text(
                                      m['title']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      m['desc']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Menu Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: categories.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryMenuScreen(category: cat['title']!),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: cat['title']!,
                            child: Image.network(
                              cat['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                          Container(
                            color: Colors.black26,
                            alignment: Alignment.center,
                            child: Text(
                              cat['title']!,
                              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      backgroundColor: AppTheme.backgroundColor,
    );
  }
}
