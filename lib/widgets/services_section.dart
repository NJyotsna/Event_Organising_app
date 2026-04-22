import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  Widget serviceItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEADBC8), // slightly darker beige
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF6D4C41),
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              serviceItem(Icons.home, "Venues"),
              serviceItem(Icons.restaurant, "Catering"),
              serviceItem(Icons.brush, "Decoration"),
              serviceItem(Icons.camera_alt, "Photography"),
              serviceItem(Icons.event, "Planning"),
            ],
          ),
        ],
      ),
    );
  }
}