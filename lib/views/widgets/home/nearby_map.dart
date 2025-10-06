import 'package:flutter/material.dart';

class NearbyMap extends StatelessWidget {
  const NearbyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'images/map.png',
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
