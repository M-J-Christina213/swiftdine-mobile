

// ignore_for_file: file_names

class CartItem {
  
  final String name;
  final String description;
  final String featuredRestaurant;
  final double price;
  final String imagePath;
  int quantity;
  

  CartItem({
    required this.name,
    required this.description,
    required this.featuredRestaurant,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}
