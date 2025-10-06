class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final List<String> featuredRestaurants;
  final double rating;
  final int likeCount;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.featuredRestaurants,
    required this.rating,
    required this.likeCount,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imagePath: json['image_url'], 
      category: json['category_name'] ?? '', 
      featuredRestaurants: [json['restaurant_name'] ?? ''], 
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
      likeCount: int.tryParse(json['like_count']?.toString() ?? '0') ?? 0,
    );
  }
}
