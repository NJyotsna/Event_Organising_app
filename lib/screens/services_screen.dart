import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  final Function(String) onServiceClick; // ✅ moved inside class

  const ServicesScreen({
    super.key,
    required this.onServiceClick,
  });

  final List<Map<String, String>> services = const [
    {"title": "Photography", "subtitle": "Wedding & event", "icon": "assets/services/photography.png"},
    {"title": "Videography", "subtitle": "Cinematic video", "icon": "assets/services/videography.png"},
    {"title": "Catering", "subtitle": "Veg & Non-Veg", "icon": "assets/services/catering.png"},
    {"title": "Decoration", "subtitle": "Theme decor", "icon": "assets/services/decoration.png"},
    {"title": "DJ & Sound", "subtitle": "Music system", "icon": "assets/services/dj.png"},
    {"title": "Lighting", "subtitle": "Lighting setup", "icon": "assets/services/lighting.png"},
    {"title": "Planning", "subtitle": "Event planning", "icon": "assets/services/planning.png"},
    {"title": "Entertainment", "subtitle": "Shows & anchors", "icon": "assets/services/entertainment.png"},
    {"title": "Makeup", "subtitle": "Bridal makeup", "icon": "assets/services/makeup.png"},
    {"title": "Invitation", "subtitle": "Cards design", "icon": "assets/services/invitation.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Services"),
        backgroundColor: const Color(0xFF7B001C),
      ),
      backgroundColor: const Color(0xFFF5EFE6),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.52,
          ),
          itemBuilder: (context, index) {
            final service = services[index];

            return GestureDetector(
              onTap: () {
                onServiceClick(service["title"]!); // ✅ works now
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        service["icon"]!,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}