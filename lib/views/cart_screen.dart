import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/providers/cart_provider.dart';
import '../../themes/app_theme.dart';
import '../views/checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {
      await cartProvider.loadCartFromDb();
    } catch (e) {
      // Handle error, e.g., show toast
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final items = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: AppTheme.primaryColor,
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text("No items in cart"))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        item.imagePath,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => cartProvider.removeItem(item),
                                                child: const Icon(Icons.delete,
                                                    color: Colors.red, size: 22),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.description,
                                            style: const TextStyle(
                                                fontSize: 13, color: Colors.grey),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "From: ${item.featuredRestaurant}",
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.black54),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "For each: Rs ${item.price.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () =>
                                                        cartProvider.decrementQuantity(item),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.redAccent,
                                                      ),
                                                      padding: const EdgeInsets.all(6),
                                                      child: const Icon(Icons.remove,
                                                          color: Colors.white, size: 18),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${item.quantity}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  InkWell(
                                                    onTap: () =>
                                                        cartProvider.incrementQuantity(item),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.green,
                                                      ),
                                                      padding: const EdgeInsets.all(6),
                                                      child: const Icon(Icons.add,
                                                          color: Colors.white, size: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Total: Rs ${(item.price * item.quantity).toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                if (items.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, -1),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Price:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Rs ${cartProvider.totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CheckoutScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
