import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../menu_screen.dart';
import '../../providers/restaurant_provider.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final int restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurant(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);
    final restaurant = provider.restaurant;

    final galleryImages = [
      'assets/images/gallery1.png',
      'assets/images/gallery2.png',
      'assets/images/gallery3.png',
      'assets/images/gallery4.png',
      'assets/images/gallery5.png',
      'assets/images/gallery6.png',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Restaurant Details"),
        backgroundColor: const Color.fromARGB(255, 255, 119, 0),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : restaurant == null
              ? const Center(child: Text("Restaurant not found"))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Banner
                      Stack(
                        children: [
                          Image.network(
                            restaurant.image.isNotEmpty
                                ? restaurant.image
                                : 'https://via.placeholder.com/600x200',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  restaurant.address,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // View Menu Button
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 132, 0),
                              shape: const StadiumBorder()),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MenuScreen()),
                            );
                          },
                          child: const Text("View Menu"),
                        ),
                      ),

                      // Restaurant Info Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoCard(
                                icon: Icons.location_on,
                                title: restaurant.address),
                            SizedBox(
                              height: 200,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      restaurant.latitude, restaurant.longitude),
                                  zoom: 15,
                                ),
                                markers: {
                                  Marker(
                                    markerId:
                                        const MarkerId('restaurant_marker'),
                                    position: LatLng(
                                        restaurant.latitude,
                                        restaurant.longitude),
                                    infoWindow:
                                        InfoWindow(title: restaurant.name),
                                  ),
                                },
                                zoomControlsEnabled: false,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const InfoCard(
                                icon: Icons.access_time,
                                title: "Today: Opens at 8PM",
                                subtitle: "Open now"),
                            const InfoCard(
                                icon: Icons.phone, title: "+94 77 123 4567"),
                            const InfoCard(
                                icon: Icons.email,
                                title: "info@restaurant.com"),
                          ],
                        ),
                      ),

                      // Dine-In Preview Section
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.table_restaurant, color: Colors.orange),
                                SizedBox(width: 8),
                                Text("Dine-in Preview",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tables Grid
                                Expanded(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: List.generate(9, (index) {
                                      final table = index + 1;
                                      final isAvailable = table > 5;
                                      return CircleAvatar(
                                        backgroundColor: isAvailable
                                            ? Colors.green
                                            : Colors.grey,
                                        radius: 28,
                                        child: Text('T$table',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Features
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Best For",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      Wrap(
                                        spacing: 8,
                                        children: const [
                                          Chip(label: Text("👤 Solo")),
                                          Chip(label: Text("❤️ Couples")),
                                          Chip(label: Text("👥 Groups"))
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      const Text("Highlights",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      ...["Private Dining", "Ocean View", "Family Friendly"]
                                          .map((e) => Row(
                                                children: [
                                                  const Icon(Icons.check, size: 16),
                                                  const SizedBox(width: 4),
                                                  Text(e),
                                                ],
                                              ))
                                          .toList()
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: const StadiumBorder()),
                              child: const Text("Reserve a Table"),
                            ),
                          ],
                        ),
                      ),

                      // Delivery & Takeaway
                      const DeliveryTakeawayCard(),

                      // Gallery Section
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.photo, color: Colors.orange),
                                SizedBox(width: 8),
                                Text("Gallery",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: galleryImages
                                  .map((imgPath) =>
                                      Image.asset(imgPath, fit: BoxFit.cover))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      // Ratings & Reviews
                      const RestaurantRatingReview(),
                    ],
                  ),
                ),
    );
  }
}

// Info Card
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const InfoCard({super.key, required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
      ),
    );
  }
}

// Delivery & Takeaway
class DeliveryTakeawayCard extends StatelessWidget {
  const DeliveryTakeawayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Delivery Available",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Minimum Order: Rs. 5000"),
                    Text("Fee: Rs. 300"),
                    Text("ETA: 30-40 mins"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Takeaway Available",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Preparation: 15-20 mins"),
                    Text("Pickup: 10AM - 9PM"),
                    Text("Curbside Pickup, Pre-order 2 days"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Ratings & Reviews
class RestaurantRatingReview extends StatelessWidget {
  const RestaurantRatingReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ratings & Reviews",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("4.6",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: List.generate(
                          5,
                          (index) =>
                              Icon(Icons.star, color: Colors.yellow[700], size: 16),
                        ),
                      ),
                      const Text("Based on 254 reviews",
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        buildRatingBar(5, 0.7),
                        buildRatingBar(4, 0.2),
                        buildRatingBar(3, 0.06),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const ReviewCard(
            name: "Nuwan Perera",
            date: "April 15, 2025",
            comment: "Delicious food and friendly staff! Highly recommended for a casual dinner.",
            image: 'assets/images/kaju.jpeg',
            avatarImage: 'assets/images/r4.png',
          ),
          const ReviewCard(
            name: "Hashini Silva",
            date: "March 22, 2025",
            comment: "Loved the ambiance. Perfect for date nights. Would visit again!",
            avatarImage: 'assets/images/r5.png',
          ),
          const ReviewCard(
            name: "Sahan Dissanayake",
            date: "February 10, 2025",
            comment: "Food was okay, but delivery took longer than expected.",
            avatarImage: 'assets/images/r6.png',
          ),
        ],
      ),
    );
  }

  Widget buildRatingBar(int stars, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text("$stars ★", style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                ),
                FractionallySizedBox(
                  widthFactor: percent,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(4)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Single Review
class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String comment;
  final String? image;
  final String avatarImage;

  const ReviewCard({
    super.key,
    required this.name,
    required this.date,
    required this.comment,
    this.image,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(avatarImage)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(date,
                        style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(comment),
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(image!, height: 80, fit: BoxFit.cover),
              )
          ],
        ),
      ),
    );
  }
}
