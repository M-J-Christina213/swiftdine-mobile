import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;
  final Color color;

  const OrderStatusChip({
    super.key,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }
}
