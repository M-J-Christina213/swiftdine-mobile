class CartItem {
  int id;
  int menuId;
  String name;
  String description;
  String featuredRestaurant;
  double price;
  String imagePath;
  int quantity;

  CartItem({
    required this.id,
    required this.menuId,
    required this.name,
    required this.description,
    required this.featuredRestaurant,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      menuId: json['menu_id'],
      name: json['name'],
      description: json['description'] ?? '',
      featuredRestaurant: json['featured_restaurant'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imagePath: json['image_path'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }
}
