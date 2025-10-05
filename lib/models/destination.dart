class Destination {
  final String name;
  final String imagePath;
  final int restaurantCount;
  final double? rating;
  final String description;

  Destination({
    required this.name,
    required this.imagePath,
    required this.restaurantCount,
    this.rating,
    required this.description,
  });
}
