import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ─── Data Model ──────────────────────────────────────────────────────────────
class Venue {
  final String id;
  final String name;
  final String location;
  final double rating;
  final String price;
  final String image;
  final String tag;
  final bool available;

  const Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.image,
    required this.tag,
    required this.available,
  });
}

const List<Venue> kVenues = [
  Venue(
    id: '1',
    name: 'The Grand Palace',
    location: 'South Delhi, New Delhi',
    rating: 4.9,
    price: '1,200',
    image: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
    tag: 'Premium',
    available: true,
  ),
  Venue(
    id: '2',
    name: 'Heritage Courtyard',
    location: 'Jaipur, Rajasthan',
    rating: 4.7,
    price: '800',
    image: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800',
    tag: 'Heritage',
    available: false,
  ),
  Venue(
    id: '3',
    name: 'Royal Orchid Retreat',
    location: 'Bandra West, Mumbai',
    rating: 4.8,
    price: '1,500',
    image: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
    tag: 'Luxury',
    available: true,
  ),
];

// ─── Venues Screen ────────────────────────────────────────────────────────────
class VenuesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> venues;
  final bool isFromLocation;
  final void Function(String id)? onSelectVenue;

  const VenuesScreen({
    super.key,
    required this.venues,
    required this.isFromLocation,
    this.onSelectVenue,
  });

  @override
  State<VenuesScreen> createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Price',
    'Rating',
    'Event Type',
    'Location',
  ];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Venue> get _filteredVenues {
    final List<Venue> displayVenues = widget.venues.map((v) {
      return Venue(
        id: v['id']?.toString() ?? '',
        name: v['name'] ?? 'Unnamed Venue',
        location: v['location'] ?? 'Unknown Location',
        rating: (v['rating'] ?? 4.5).toDouble(),
        price: v['price_per_plate']?.toString() ?? v['price']?.toString() ?? '1000',
        image: v['image_url'] ?? v['image'] ?? 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
        tag: v['tag'] ?? 'Premium',
        available: v['available'] ?? true,
      );
    }).toList();

    return displayVenues.where((v) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          v.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          v.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _Header(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _SearchBar(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) => _FilterChip(
                      label: _filters[i],
                      isSelected: _selectedFilter == _filters[i],
                      onTap: () =>
                          setState(() => _selectedFilter = _filters[i]),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                child: Text(
                  '${_filteredVenues.length} venues found',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _VenueCard(
                      venue: _filteredVenues[index],
                      onTap: () {
                        if (widget.onSelectVenue != null) {
                          widget.onSelectVenue!(_filteredVenues[index].id);
                        }
                      },
                    ),
                  ),
                  childCount: _filteredVenues.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Venues',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.maroon,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Curated spaces for celebrations.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.maroon.withOpacity(0.15), width: 1.5),
            image: const DecorationImage(
              image: NetworkImage('https://i.pravatar.cc/150?img=47'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEEE7DF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.maroon.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.search_rounded, color: Colors.grey[400], size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 15, color: AppColors.onSurface),
              decoration: InputDecoration(
                hintText: 'Find venues, services...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.maroon,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.maroon.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : AppColors.cream,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? AppColors.gold : AppColors.maroon.withOpacity(0.12),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: isSelected ? AppColors.maroon : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class _VenueCard extends StatefulWidget {
  final Venue venue;
  final VoidCallback onTap;

  const _VenueCard({required this.venue, required this.onTap});

  @override
  State<_VenueCard> createState() => _VenueCardState();
}

class _VenueCardState extends State<_VenueCard>
    with SingleTickerProviderStateMixin {
  bool _isFavourite = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.maroon.withOpacity(0.07),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardImage(
                venue: widget.venue,
                isFavourite: _isFavourite,
                onFavTap: () {
                  setState(() => _isFavourite = !_isFavourite);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.venue.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: AppColors.maroon,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.gold.withOpacity(0.25)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 14, color: AppColors.gold),
                              const SizedBox(width: 4),
                              Text(
                                widget.venue.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.maroon,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 15, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(
                          widget.venue.location,
                          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(color: AppColors.maroon.withOpacity(0.07), height: 1),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STARTING FROM',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[400],
                              ),
                            ),
                            const SizedBox(height: 3),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₹${widget.venue.price}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' / plate',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: widget.venue.available ? widget.onTap : null,
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Venue venue;
  final bool isFavourite;
  final VoidCallback onFavTap;

  const _CardImage({
    required this.venue,
    required this.isFavourite,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            venue.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image_rounded, size: 48, color: Colors.grey),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.18)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onFavTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isFavourite ? AppColors.maroon : Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  size: 18,
                  color: isFavourite ? Colors.white : AppColors.maroon,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Row(
              children: [
                _Badge(label: venue.tag),
                const SizedBox(width: 6),
                _AvailabilityBadge(available: venue.available),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.maroon.withOpacity(0.12)),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: AppColors.maroon,
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  final bool available;
  const _AvailabilityBadge({required this.available});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: available ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            available ? 'Available' : 'Booked',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
