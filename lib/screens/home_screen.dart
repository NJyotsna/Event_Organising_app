import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/search_card.dart';
import '../widgets/trust_section.dart';
import '../widgets/services_section.dart';
import '../services/location_service.dart';
import '../services/supabase_service.dart';
import 'venues_screen.dart';
import 'services_screen.dart';
import 'service_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedService = "";
  bool showServiceDetails = false;

  List<Map<String, dynamic>> venues = [];
  bool isFromLocation = true; // 🔥 IMPORTANT

  List<Widget> get _screens => [
    // 🏠 HOME
    SingleChildScrollView(
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

    // 📍 VENUES
    VenuesScreen(
      venues: venues,
      isFromLocation: isFromLocation,
    ),

    // 📖 BOOKINGS
    const Center(child: Text("Bookings coming soon")),

    // 🛠 SERVICES
    showServiceDetails
        ? ServiceDetailScreen(
      serviceName: selectedService,
      onBack: () {
        setState(() {
          showServiceDetails = false;
        });
      },
    )
        : ServicesScreen(
      onServiceClick: (service) {
        setState(() {
          selectedService = service;
          showServiceDetails = true;
        });
      },
    ),

    // 👤 PROFILE
    const Center(child: Text("Profile coming soon")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,

        onTap: (index) async {
          if (index == 1) {
            final locationService = LocationService();
            final supabaseService = SupabaseService();

            try {
              final position = await locationService.getUserLocation();

              final data = await supabaseService.getNearbyVenues(
                userLat: position.latitude,
                userLng: position.longitude,
                guests: 100,
              );

              if (!mounted) return;

              setState(() {
                venues = data;
                isFromLocation = true; // 🔥 GPS
                _selectedIndex = index;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Location permission needed"),
                ),
              );
            }
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Venues"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services),
              label: "Services"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}