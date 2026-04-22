import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/search_card.dart';
import '../widgets/trust_section.dart';
import '../widgets/services_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),

            Transform.translate(
              offset: const Offset(0, -40),
              child: const SearchCard(),
            ),

            const SizedBox(height: 10),
            const TrustSection(),

            const SizedBox(height: 10),
            const ServicesSection(),
          ],
        ),
      ),

      // ❌ NO const here
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Venues",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}