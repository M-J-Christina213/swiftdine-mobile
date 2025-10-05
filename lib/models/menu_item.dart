class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath; 
  final String category;
  final int likeCount;
  final List<String> featuredRestaurants;
  final double rating;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    this.likeCount = 0,
    required this.featuredRestaurants,
    this.rating = 0.0,
  });
}
