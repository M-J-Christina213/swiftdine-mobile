import 'package:flutter/material.dart';
import 'package:swiftdine_mobile/themes/app_theme.dart';
import 'order_status_chip.dart';
import 'package:swiftdine_mobile/models/order.dart';

class PastOrderCard extends StatelessWidget {
  final Order order;
  const PastOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order.items.map((i) => "${i.name} x${i.quantity}").join(", ");

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order #${order.orderNumber}", style: AppTheme.headingStyle),
            const SizedBox(height: 8),
            Text("Items: $items", style: AppTheme.descriptionStyle),
            const SizedBox(height: 8),
            Text("Total: LKR ${order.total.toStringAsFixed(2)}",
                style: AppTheme.priceStyle),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: ${order.createdAt.split('T')[0]}"),
                const OrderStatusChip(status: "Delivered", color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
