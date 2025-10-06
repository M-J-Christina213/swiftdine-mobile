import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destination.dart';

class HomeController {
  final String apiUrl = "http://10.0.2.2:8000/api/restaurants"; // Localhost API
  bool useApi = true; 

  Future<List<Destination>> fetchDestinations() async {
    if (!useApi) {
      // Offline (local) fallback data
      return [
        Destination(
          name: 'Colombo',
          imagePath: 'assets/images/colombo.jpg',
          restaurantCount: 126,
          rating: 4.7,
          description: 'Discover delicious meals across Colombo.',
        ),
        Destination(
          name: 'Galle',
          imagePath: 'assets/images/galle.jpeg',
          restaurantCount: 87,
          rating: 4.5,
          description: 'Explore scenic hotspots in Galle.',
        ),
        Destination(
          name: 'Kandy',
          imagePath: 'assets/images/kandy.jpeg',
          restaurantCount: 68,
          rating: 4.6,
          description: 'Enjoy traditional dining in Kandy.',
        ),
      ];
    }

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((item) {
          return Destination(
            name: item['name'] ?? 'Unknown',
            imagePath: "http://10.0.2.2:8000/storage/${item['image_path']}",
            restaurantCount: 0,
            rating: double.tryParse(item['rating'].toString()) ?? 0.0,
            description: item['cuisine'] ?? '',
          );
        }).toList();
      } else {
        throw Exception("Failed to load restaurants (Status ${response.statusCode})");
      }
    } catch (e) {
      return [];
    }
  }
}
