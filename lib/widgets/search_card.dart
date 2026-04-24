import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../screens/venues_screen.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // LOCATION
          TextField(
            controller: locationController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on),
              hintText: "Enter location",
            ),
          ),

          const SizedBox(height: 12),

          // DATE PICKER
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );

              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text(
                    selectedDate == null
                        ? "Select date"
                        : "${selectedDate!.toLocal()}".split(' ')[0],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // GUESTS
          TextField(
            controller: guestsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.people),
              hintText: "Number of guests",
            ),
          ),

          const SizedBox(height: 18),

          // 🔥 SEARCH BUTTON
          GestureDetector(
            onTap: () async {
              final location = locationController.text.trim();
              final guests = int.tryParse(guestsController.text) ?? 0;

              if (location.isEmpty || guests == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Fill all fields")),
                );
                return;
              }

              final service = SupabaseService();

              final venues = await service.getAvailableVenues(
                location: location,
                guests: guests,
              );

              if (!context.mounted) return;

              if (venues.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No venues found")),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VenuesScreen(
                      venues: venues,
                      isFromLocation: false, // 🔥 IMPORTANT (typed search)
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  "Check Live Availability",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2C23),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}