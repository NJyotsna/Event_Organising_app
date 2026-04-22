import 'package:flutter/material.dart';

class TrustSection extends StatelessWidget {
  const TrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Trust & Emotion Section",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          // ✅ FIX: scroll instead of overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                trustItem(Icons.verified, "Verified Venues"),
                const SizedBox(width: 12),
                trustItem(Icons.currency_rupee, "Transparent Pricing"),
                const SizedBox(width: 12),
                trustItem(Icons.block, "No Broker"),
                const SizedBox(width: 12),
                trustItem(Icons.family_restroom, "Family Friendly"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget trustItem(IconData icon, String text) {
    return SizedBox(
      width: 90, // ✅ FIX: fixed width prevents overflow
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEADBC8), // soft beige like your UI
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6D4C41),
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}