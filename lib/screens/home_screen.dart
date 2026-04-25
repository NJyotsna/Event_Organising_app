import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/header.dart';
import '../widgets/search_card.dart';
import '../widgets/trust_section.dart';
import '../widgets/services_section.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/loading_view.dart';
import '../services/location_service.dart';
import '../services/supabase_service.dart';
import '../theme/app_colors.dart';
import 'venues_screen.dart';
import 'services_screen.dart';
import 'service_detail_screen.dart';
import 'profile_screen.dart';
import 'venuedetails_screen.dart';
import 'booking_screen.dart';

// ─── Nav Tab Configuration ───────────────────────────────────────────────────
const _tabs = [
  NavTab(Icons.home_outlined, Icons.home_rounded, 'Home'),
  NavTab(Icons.location_city_outlined, Icons.location_city_rounded, 'Venues'),
  NavTab(Icons.calendar_today_outlined, Icons.calendar_today_rounded, 'Bookings'),
  NavTab(Icons.celebration_outlined, Icons.celebration_rounded, 'Services'),
  NavTab(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
];

// ─── HomeScreen ───────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Venues state
  List<Map<String, dynamic>> venues = [];
  bool isFromLocation = true;
  bool showVenueDetails = false;
  String selectedVenueId = '';

  // Services state
  String selectedService = '';
  bool showServiceDetails = false;

  // Loading state
  bool _venuesLoading = false;

  // ── Screen builder ──────────────────────────────────────────────────────────
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const _HomeTab();

      case 1:
        if (showVenueDetails) {
          return VenueDetailsScreen(
            onBack: () => setState(() => showVenueDetails = false),
          );
        }
        if (_venuesLoading) {
          return const LoadingView(message: 'Finding venues near you…');
        }
        return VenuesScreen(
          venues: venues,
          isFromLocation: isFromLocation,
          onSelectVenue: (id) => setState(() {
            selectedVenueId = id;
            showVenueDetails = true;
          }),
        );

      case 2:
        return const BookingsScreen();

      case 3:
        if (showServiceDetails) {
          return ServiceDetailScreen(
            serviceName: selectedService,
            onBack: () => setState(() => showServiceDetails = false),
          );
        }
        return ServicesScreen(
          onServiceClick: (service) => setState(() {
            selectedService = service;
            showServiceDetails = true;
          }),
        );

      case 4:
        return const ProfileScreen();

      default:
        return const SizedBox.shrink();
    }
  }

  // ── Tab tap handler ──────────────────────────────────────────────────────────
  Future<void> _onTabTap(int index) async {
    // Reset sub-navigation when switching away
    if (index != 1) setState(() => showVenueDetails = false);
    if (index != 3) setState(() => showServiceDetails = false);

    if (index == 1 && venues.isEmpty) {
      setState(() {
        _selectedIndex = index;
        _venuesLoading = true;
      });

      try {
        final locationService = LocationService();
        final supabaseService = SupabaseService();
        
        final position = await locationService.getUserLocation();
        final data = await supabaseService.getNearbyVenues(
          userLat: position.latitude,
          userLng: position.longitude,
          guests: 50, // More realistic default
        );
        
        if (!mounted) return;
        setState(() {
          venues = data;
          isFromLocation = true;
          _venuesLoading = false;
        });
      } catch (e) {
        if (!mounted) return;
        setState(() => _venuesLoading = false);
        
        String errorMsg = 'Could not fetch venues';
        if (e.toString().contains('permission')) {
          errorMsg = 'Location permission is required';
        } else if (e.toString().contains('network')) {
          errorMsg = 'Check your internet connection';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: AppColors.maroon,
          ),
        );
      }
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle back button for detail screens
    return PopScope(
      canPop: !showVenueDetails && !showServiceDetails,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (showVenueDetails) {
          setState(() => showVenueDetails = false);
        } else if (showServiceDetails) {
          setState(() => showServiceDetails = false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cream,
        extendBody: true,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.02),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey('$_selectedIndex-$showVenueDetails-$showServiceDetails'),
            child: _buildScreen(_selectedIndex),
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
          selectedIndex: _selectedIndex,
          tabs: _tabs,
          onTap: _onTabTap,
        ),
      ),
    );
  }
}

// ─── Home Tab Content ─────────────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    // Calculate clearance for bottom nav + floating space
    final bottomPadding = MediaQuery.of(context).padding.bottom + 100;

    return SingleChildScrollView(
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
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
