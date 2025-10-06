import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/views/widgets/orders/past_order_card.dart';
import 'package:swiftdine_mobile/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PastOrdersTab extends StatefulWidget {
  const PastOrdersTab({super.key});

  @override
  State<PastOrdersTab> createState() => _PastOrdersTabState();
}

class _PastOrdersTabState extends State<PastOrdersTab> {
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/orders'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          orders = data
              .map((json) => Order.fromJson(json))
              .where((o) => o.status == 'Delivered')
              .toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orders.isEmpty) {
      return const Center(child: Text("No past orders."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return PastOrderCard(order: orders[index]);
      },
    );
  }
}
