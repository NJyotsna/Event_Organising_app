import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 60),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8B0000),
            Color(0xFFB22222),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "VenueSetu",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Find. Check Availability. Book Instantly.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          Row(
            children: [
              const Icon(Icons.notifications, color: Colors.white),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: const Icon(Icons.chat, color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}