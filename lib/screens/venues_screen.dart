import 'package:flutter/material.dart';

class VenuesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> venues;
  final bool isFromLocation; // 🔥 controls distance visibility

  const VenuesScreen({
    super.key,
    required this.venues,
    required this.isFromLocation,
  });

  @override
  State<VenuesScreen> createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  String selectedFilter = "All";

  // 🔥 Venue images
  final List<String> images = [
    "https://images.unsplash.com/photo-1519741497674-611481863552?w=800",
    "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=800",
    "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800",
    "https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800",
    "https://images.unsplash.com/photo-1505236858219-8359eb29e329?w=800",
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ FILTER LOGIC (SAFE TYPE)
    List<Map<String, dynamic>> filteredVenues =
    widget.venues.where((v) {
      if (selectedFilter == "All") return true;

      if (selectedFilter == "Budget") return (v['capacity'] ?? 0) <= 200;

      if (selectedFilter == "Luxury") return (v['capacity'] ?? 0) >= 300;

      if (selectedFilter == "300+ Guests")
        return (v['capacity'] ?? 0) >= 300;

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venues"),
        backgroundColor: const Color(0xFF7B001C),
      ),
      backgroundColor: const Color(0xFFF5EFE6),

      body: Column(
        children: [
          // 🔥 FILTER CHIPS
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildFilterChip("All"),
                buildFilterChip("Budget"),
                buildFilterChip("Luxury"),
                buildFilterChip("300+ Guests"),
              ],
            ),
          ),

          // 🔽 VENUES LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredVenues.length,
              itemBuilder: (context, index) {
                final venue = filteredVenues[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 📸 IMAGE
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        child: Image.network(
                          images[index % images.length],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image, size: 40),
                              ),
                            );
                          },
                        ),
                      ),

                      // 📋 DETAILS
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔤 NAME
                            Text(
                              venue['name'] ?? "No Name",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // 📍 LOCATION
                            Text("📍 ${venue['location'] ?? "Unknown"}"),

                            const SizedBox(height: 4),

                            // 📏 DISTANCE (ONLY GPS)
                            if (widget.isFromLocation &&
                                venue['distance'] != null)
                              Text(
                                "${(venue['distance'] as double).toStringAsFixed(1)} km away",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),

                            const SizedBox(height: 6),

                            // 👥 CAPACITY
                            Text(
                                "Capacity: ${venue['capacity'] ?? "N/A"}"),

                            const SizedBox(height: 6),

                            // 💰 PRICE (optional but useful)
                            if (venue['price'] != null)
                              Text("💰 ₹${venue['price']}"),

                            const SizedBox(height: 8),

                            // 🟢 AVAILABILITY
                            Row(
                              children: const [
                                Icon(Icons.circle,
                                    color: Colors.green, size: 10),
                                SizedBox(width: 6),
                                Text(
                                  "Available",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text("View Details"),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: venue['available'] == true ? () {} : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7B001C),
                                    ),
                                    child: const Text("Book Now"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 FILTER CHIP UI
  Widget buildFilterChip(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selectedFilter == label
              ? const Color(0xFF7B001C)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
            selectedFilter == label ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}