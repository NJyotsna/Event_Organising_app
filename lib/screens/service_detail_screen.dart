import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/supabase_service.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String serviceName;
  final VoidCallback onBack;

  const ServiceDetailScreen({
    super.key,
    required this.serviceName,
    required this.onBack,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  List<Map<String, dynamic>> vendors = [];
  bool isLoading = true;

  String selectedFilter = "All"; // 🔥 NEW

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askLocationChoice();
    });
  }

  // ===============================
  // 📍 LOCATION CHOICE
  // ===============================
  Future<void> askLocationChoice() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Location"),
          content: const Text("Choose how you want to search"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await fetchUsingCurrentLocation();
              },
              child: const Text("Use Current Location"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                askCityInput();
              },
              child: const Text("Enter City"),
            ),
          ],
        );
      },
    );
  }

  // ===============================
  // 📍 FETCH DATA
  // ===============================
  Future<void> fetchUsingCurrentLocation() async {
    try {
      final locationService = LocationService();
      final supabaseService = SupabaseService();

      await locationService.getUserLocation();

      final data =
      await supabaseService.getServicesByType(widget.serviceName);

      setState(() {
        vendors = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission needed")),
      );
    }
  }

  void askCityInput() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter City"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "e.g. Vijayawada",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await fetchUsingCity(controller.text);
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchUsingCity(String city) async {
    final supabaseService = SupabaseService();

    final data =
    await supabaseService.getServicesByType(widget.serviceName);

    final filtered = data
        .where((v) =>
    v['location'].toString().toLowerCase() ==
        city.toLowerCase())
        .toList();

    setState(() {
      vendors = filtered;
      isLoading = false;
    });
  }

  // ===============================
  // 🖼️ CATEGORY IMAGE
  // ===============================
  String getServiceImage(String type) {
    switch (type) {
      case "Photography":
        return "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800";
      case "Videography":
        return "https://images.unsplash.com/photo-1492724441997-5dc865305da7?w=800";
      case "Catering":
        return "https://images.unsplash.com/photo-1555244162-803834f70033?w=800";
      case "Decoration":
        return "https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800";
      case "DJ & Sound":
        return "https://images.unsplash.com/photo-1506157786151-b8491531f063?w=800";
      case "Lighting":
        return "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800";
      case "Planning":
        return "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=800";
      case "Entertainment":
        return "https://images.unsplash.com/photo-1497032628192-86f99bcd76bc?w=800";
      case "Makeup":
        return "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=800";
      case "Invitation":
        return "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800";
      default:
        return "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800";
    }
  }

  // ===============================
  // 🔍 FILTER LOGIC
  // ===============================
  List<Map<String, dynamic>> getFilteredVendors() {
    return vendors.where((v) {
      if (selectedFilter == "All") return true;

      final price = v['price'] ?? 0;

      if (selectedFilter == "Under ₹10K") return price < 10000;
      if (selectedFilter == "₹10K-₹25K")
        return price >= 10000 && price <= 25000;
      if (selectedFilter == "₹25K-₹50K")
        return price >= 25000 && price <= 50000;
      if (selectedFilter == "₹50K+") return price > 50000;

      return true;
    }).toList();
  }

  // ===============================
  // UI
  // ===============================
  @override
  Widget build(BuildContext context) {
    final filtered = getFilteredVendors();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
        backgroundColor: const Color(0xFF7B001C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      backgroundColor: const Color(0xFFF5EFE6),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 🔍 FILTERS
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildFilter("All"),
                buildFilter("Under ₹10K"),
                buildFilter("₹10K-₹25K"),
                buildFilter("₹25K-₹50K"),
                buildFilter("₹50K+"),
              ],
            ),
          ),

          // 📋 LIST
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text("No vendors found"))
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final v = filtered[index];

                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6)
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          getServiceImage(widget.serviceName),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(v['name'],
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold)),

                            Text("📍 ${v['location']}"),
                            Text("₹${v['price']}"),

                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange,
                                    size: 16),
                                Text(" ${v['rating']}"),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text(
                                        "View Details"),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton
                                        .styleFrom(
                                      backgroundColor:
                                      const Color(
                                          0xFF7B001C),
                                    ),
                                    child: const Text(
                                        "Book Now"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
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

  Widget buildFilter(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: selectedFilter == label,
        onSelected: (_) {
          setState(() {
            selectedFilter = label;
          });
        },
      ),
    );
  }
}