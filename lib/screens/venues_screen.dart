import 'package:flutter/material.dart';

class VenuesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> venues;

  const VenuesScreen({super.key, required this.venues});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Venues"),
        backgroundColor: const Color(0xFF7B001C),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1519741497674-611481863552",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image,
                              size: 40, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME
                      Text(
                        venue['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // LOCATION
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            venue['location'],
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // CAPACITY
                      Text(
                        "Capacity: ${venue['capacity']}",
                        style: const TextStyle(fontSize: 13),
                      ),

                      const SizedBox(height: 8),

                      // AVAILABLE
                      const Row(
                        children: [
                          Icon(Icons.circle,
                              color: Colors.green, size: 10),
                          SizedBox(width: 6),
                          Text(
                            "Available",
                            style: TextStyle(
                                color: Colors.green, fontSize: 13),
                          )
                        ],
                      ),

                      const SizedBox(height: 12),

                      // VIEW DETAILS
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B001C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text("Viewing ${venue['name']}"),
                              ),
                            );
                          },
                          child: const Text("View Details"),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // BOOK NOW
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text("Booked ${venue['name']}"),
                              ),
                            );
                          },
                          child: const Text("Book Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}