import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/menu_item.dart';
import '../../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../../themes/app_theme.dart';

class MenuList extends StatefulWidget {
  final String? category;
  final String? restaurantId;

  const MenuList({super.key, this.category, this.restaurantId});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  late Future<List<MenuItem>> _futureMenus;

  Map<int, int> quantities = {}; 

  final String apiBaseUrl = "http://10.0.2.2:8000/api";

  @override
  void initState() {
    super.initState();
    _futureMenus = fetchMenus();
  }

  Future<List<MenuItem>> fetchMenus() async {
    final url = widget.restaurantId != null
        ? Uri.parse('$apiBaseUrl/restaurants/${widget.restaurantId}/menu')
        : Uri.parse('$apiBaseUrl/menus');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((item) => MenuItem.fromJson(item))
          .toList()
          .where((item) =>
              widget.category == null || item.category == widget.category)
          .toList();
    } else {
      throw Exception('Failed to load menu');
    }
  }

  void add(int id) {
    setState(() {
      quantities[id] = (quantities[id] ?? 0) + 1;
    });
  }

  void remove(int id) {
    final qty = quantities[id] ?? 0;
    if (qty > 1) {
      setState(() {
        quantities[id] = qty - 1;
      });
    } else {
      setState(() {
        quantities.remove(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<MenuItem>>(
      future: _futureMenus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found'));
        }

        final menus = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            if (widget.category != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text("${widget.category!} Menu",
                    style: theme.textTheme.headlineSmall),
              ),
            ...menus.map((item) => buildMenuItemCard(item, theme)),
          ],
        );
      },
    );
  }

  Widget buildMenuItemCard(MenuItem item, ThemeData theme) {
    final int itemId = int.tryParse(item.id) ?? 0; // convert String id → int
    final qty = quantities[itemId] ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(item.description,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text("Rating: ${item.rating} ★",
                      style: TextStyle(color: Colors.orange.shade800)),
                  Text("From: ${item.featuredRestaurants.join(", ")}",
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.blueGrey)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Rs ${item.price.toStringAsFixed(2)}",
                              style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.deepOrangeAccent)),
                          const SizedBox(width: 12),
                          buildQuantityControls(item, theme, itemId),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            add(itemId);
                            Provider.of<CartProvider>(context, listen: false)
                                .addItem(CartItem(
                              id: itemId,
                              menuId: itemId,
                              name: item.name,
                              description: item.description,
                              featuredRestaurant:
                                  item.featuredRestaurants.join(', '),
                              price: item.price,
                              imagePath: item.imagePath,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${item.name} added to cart")));
                          },
                          icon: const Icon(Icons.shopping_cart, size: 18),
                          label: Text(
                            qty == 0 ? "Add to Cart" : "Add More",
                            style: const TextStyle(fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuantityControls(MenuItem item, ThemeData theme, int itemId) {
    final qty = quantities[itemId] ?? 0;
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
          onPressed: qty > 0 ? () => remove(itemId) : null,
          visualDensity: VisualDensity.compact,
        ),
        Text("$qty", style: theme.textTheme.titleMedium),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.green),
          onPressed: () {
            add(itemId);
            Provider.of<CartProvider>(context, listen: false).addItem(CartItem(
              id: itemId,
              menuId: itemId,
              name: item.name,
              description: item.description,
              featuredRestaurant: item.featuredRestaurants.join(', '),
              price: item.price,
              imagePath: item.imagePath,
            ));
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${item.name} added to cart")));
          },
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}
