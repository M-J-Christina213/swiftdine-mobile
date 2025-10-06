import 'order_item.dart';

class Order {
  final int id;
  final String orderNumber;
  final String customerName;
  final String status;
  final double total;
  final String createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    return Order(
      id: json['id'],
      orderNumber: json['order_number'].toString(),
      customerName: json['customer_name'],
      status: json['status'],
      total: double.parse(json['total'].toString()),
      createdAt: json['created_at'],
      items: itemsJson.map((e) => OrderItem.fromJson(e)).toList(),
    );
  }
}
