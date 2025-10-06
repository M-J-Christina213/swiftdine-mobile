class Restaurant {
  final int id;
  final String name;
  final String image;
  final String address;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }
}
