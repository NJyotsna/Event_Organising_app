import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────
class _Amenity {
  final IconData icon;
  final String label;
  const _Amenity(this.icon, this.label);
}

const _amenities = [
  _Amenity(Icons.wifi_rounded, 'High-Speed WiFi'),
  _Amenity(Icons.ac_unit_rounded, 'Central AC'),
  _Amenity(Icons.directions_car_rounded, 'Valet Parking'),
  _Amenity(Icons.restaurant_rounded, 'In-house Catering'),
  _Amenity(Icons.auto_awesome_rounded, 'Bridal Suite'),
];

class _Review {
  final String name;
  final String avatar;
  final Color color;
  final String text;
  const _Review(this.name, this.avatar, this.color, this.text);
}

const _reviews = [
  _Review(
    'Ananya S.',
    'A',
    AppColors.gold,
    'Absolutely breathtaking venue. The attention to detail in the decor was unmatched. Truly a royal affair.',
  ),
  _Review(
    'Rahul V.',
    'R',
    AppColors.maroon,
    'Great location and excellent catering. Highly recommended for evening receptions.',
  ),
];

// ─── VenueDetails Screen ──────────────────────────────────────────────────────
class VenueDetailsScreen extends StatefulWidget {
  final VoidCallback onBack;
  const VenueDetailsScreen({super.key, required this.onBack});

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _selectedPackage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: widget.onBack),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Gallery(),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _TitleRow(),
                          const SizedBox(height: 32),
                          const _SectionTitle('About the Venue'),
                          const SizedBox(height: 12),
                          const _AboutText(),
                          const SizedBox(height: 32),
                          const _SectionTitle('Amenities'),
                          const SizedBox(height: 16),
                          const _AmenitiesWrap(),
                          const SizedBox(height: 32),
                          const _ReviewsSection(),
                          const SizedBox(height: 32),
                          _BookingCard(
                            selectedPackage: _selectedPackage,
                            onPackageChanged: (v) =>
                                setState(() => _selectedPackage = v),
                          ),
                          const SizedBox(height: 16),
                          const _NeedHelpCard(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.cream.withOpacity(0.95),
        border: Border(bottom: BorderSide(color: AppColors.maroon.withOpacity(0.06))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.maroon, size: 24),
            splashRadius: 22,
          ),
          const Text(
            'VenueSetu',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.maroon,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded, color: AppColors.maroon, size: 22),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=1200',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.28)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.photo_library_rounded, color: Colors.white, size: 15),
                  SizedBox(width: 6),
                  Text(
                    '+12 Photos',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                'The Grand Palace',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: AppColors.maroon,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.star_rounded, size: 14, color: AppColors.maroon),
                  SizedBox(width: 4),
                  Text(
                    '4.9',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: AppColors.maroon,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on_rounded, size: 18, color: AppColors.maroon),
            const SizedBox(width: 6),
            Text(
              'Heritage Block, Royal Enclave, Jaipur',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.maroon,
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText();
  @override
  Widget build(BuildContext context) {
    return Text(
      'Experience the epitome of ethnic luxury at The Grand Palace. This heritage property blends '
      'traditional Rajputana architecture with modern world-class amenities. Perfect for grand '
      'weddings, exclusive corporate retreats, and milestone celebrations, our venue offers an '
      'unforgettable ambiance bathed in warm lighting, rich maroon accents, and golden detailing.',
      style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.7),
    );
  }
}

class _AmenitiesWrap extends StatelessWidget {
  const _AmenitiesWrap();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _amenities
          .map(
            (a) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.maroon.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.maroon.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(a.icon, size: 18, color: AppColors.maroon),
                  const SizedBox(width: 8),
                  Text(
                    a.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _SectionTitle('Guest Reviews'),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See all 124 reviews',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.maroon,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._reviews.map(
          (r) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _ReviewCard(review: r),
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.maroon.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.maroon.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(shape: BoxShape.circle, color: review.color),
                child: Center(
                  child: Text(
                    review.avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(Icons.star_rounded, size: 13, color: AppColors.gold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '"${review.text}"',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final int selectedPackage;
  final ValueChanged<int> onPackageChanged;

  const _BookingCard({
    required this.selectedPackage,
    required this.onPackageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.maroon.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: AppColors.maroon.withOpacity(0.10),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STARTING FROM',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w900,
              color: AppColors.gold.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: '₹2,50,000',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.maroon),
                ),
                TextSpan(
                  text: ' / day',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Available Packages',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.onSurface),
          ),
          const SizedBox(height: 12),
          _PackageOption(
            selected: selectedPackage == 0,
            title: 'Gold Package',
            desc: 'Venue + Basic Decor + Standard Catering (up to 200 pax)',
            onTap: () => onPackageChanged(0),
          ),
          const SizedBox(height: 10),
          _PackageOption(
            selected: selectedPackage == 1,
            title: 'Platinum Package',
            desc: 'Venue + Premium Decor + Elite Catering + Photography',
            onTap: () => onPackageChanged(1),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Book Now', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "You won't be charged yet",
              style: TextStyle(fontSize: 11, color: Colors.grey[400], fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageOption extends StatelessWidget {
  final bool selected;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _PackageOption({
    required this.selected,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.maroon.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.maroon : AppColors.maroon.withOpacity(0.10),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? AppColors.maroon : Colors.grey[400]!, width: 2),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.maroon),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: selected ? AppColors.maroon : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500], height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeedHelpCard extends StatefulWidget {
  const _NeedHelpCard();
  @override
  State<_NeedHelpCard> createState() => _NeedHelpCardState();
}

class _NeedHelpCardState extends State<_NeedHelpCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.maroon.withOpacity(0.10) : AppColors.maroon.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.maroon.withOpacity(0.10)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.12),
                border: Border.all(color: AppColors.gold.withOpacity(0.25)),
              ),
              child: const Icon(Icons.headset_mic_rounded, color: AppColors.maroon, size: 26),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Need Help?', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.maroon)),
                const SizedBox(height: 3),
                Text(
                  'Talk to our event specialist',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
