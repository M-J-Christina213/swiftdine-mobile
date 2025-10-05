
import 'package:swiftdine_app/models/menu_item.dart';

final List<MenuItem> menuItems = [
  MenuItem(
    id: '1',
    name: 'Chicken Curry',
    description: 'Spicy Sri Lankan chicken curry',
    price: 12.5,
    imagePath: 'assets/images/chicken_curry.jpg',
    category: 'Sri Lankan Special',
    likeCount: 25,
    featuredRestaurants: ['Royal Choice'],
    rating: 4.5,
  ),
  MenuItem(
    id: '2',
    name: 'Seafood Fried Rice',
    description: 'Delicious fried rice with fresh seafood',
    price: 10.0,
    imagePath: 'assets/images/seafood_fried_rice.jpg',
    category: 'Seafood Dishes',
    likeCount: 18,
    featuredRestaurants: ['Ocean Delight'],
    rating: 4.2,
  ),
  MenuItem(
    id: '3',
    name: 'Vegetable Spring Rolls',
    description: 'Crispy spring rolls filled with vegetables',
    price: 6.0,
    imagePath: 'assets/images/veg_spring_rolls.jpg',
    category: 'Chinese',
    likeCount: 30,
    featuredRestaurants: ['Taste of Asia'],
    rating: 4.7,
  ),
];