import 'package:flutter/material.dart';

class MostPopularFoodsSection extends StatelessWidget {
  const MostPopularFoodsSection({super.key});

  final List<Map<String, dynamic>> foods = const [
    {
      "name": "Sri Lankan Prawn Curry",
      "description": "Juicy prawns simmered in coconut milk & spices",
      "rating": 4.5,
      "price": "LKR 2,300",
      "image":
          "https://images.squarespace-cdn.com/content/v1/624fa63d5ba99559345806e6/7a61d184-c013-41b1-885e-89836d273e42/EG5_EP84_Sri-Lankan-Prawn-Curry.jpg",
    },
    {
      "name": "Egg Hoppers (Appa)",
      "description": "Crispy bowl-shaped pancakes with egg center",
      "rating": 4.4,
      "price": "LKR 450",
      "image":
          "https://i0.wp.com/www.lavenderandlovage.com/wp-content/uploads/2016/05/Sri-Lankan-Egg-Hoppers-for-Breakfast.jpg?fit=1200%2C901&ssl=1",
    },
    {
      "name": "Chicken Kottu Roti",
      "description": "Spicy chopped roti with chicken & vegetables",
      "rating": 4.8,
      "price": "LKR 1,200",
      "image":
          "https://www.theflavorbender.com/wp-content/uploads/2018/03/Chicken-Kottu-Roti-6086.jpg",
    },
    {
      "name": "Mixed Fried Rice",
      "description": "Basmati rice with egg, chicken, and prawns",
      "rating": 4.6,
      "price": "LKR 1,600",
      "image":
          "https://www.onceuponachef.com/images/2023/12/Fried-Rice-Hero-12.jpg",
    },
    {
      "name": "Devilled Chicken",
      "description": "Sweet & spicy stir-fried chicken chunks",
      "rating": 4.3,
      "price": "LKR 1,400",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi1mqee0j3rsa01DNdonytVyHbxVZ3L0qdfg&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Header
          Column(
            children: [
              Text(
                'Most Popular Foods',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Loved by locals and tourists — authentic Sri Lankan & Asian favorites!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.green.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Food list
          Column(
            children: foods.map((food) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        food['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food['name'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            food['description'],
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow.shade700, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '(${food['rating'].toString()})',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.yellow.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      food['price'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
