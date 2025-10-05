class Restaurant {
  final int id;
  final String name;
  final String location;
  final String cuisine;
  final String imagePath;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.cuisine,
    required this.imagePath,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      cuisine: json['cuisine'],
      imagePath: json['image_path'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
