import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ─── Data Model ───────────────────────────────────────────────────────────────
class _Booking {
  final String id;
  final String venue;
  final String date;
  final String time;
  final String image;
  final String status;
  final Color statusColor;

  const _Booking({
    required this.id,
    required this.venue,
    required this.date,
    required this.time,
    required this.image,
    required this.status,
    required this.statusColor,
  });
}

const _bookings = [
  _Booking(
    id: 'VS-8492',
    venue: 'The Royal Heritage Palace',
    date: '24 October 2024',
    time: '18:00 – 23:30 (Evening Slot)',
    image: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
    status: 'Confirmed',
    statusColor: Colors.green,
  ),
  _Booking(
    id: 'VS-8495',
    venue: 'Botanical Serenity Gardens',
    date: '15 November 2024',
    time: '10:00 – 16:00 (Day Slot)',
    image: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=800',
    status: 'Pending Approval',
    statusColor: AppColors.gold,
  ),
];

const _filterTabs = ['Upcoming', 'Past', 'Cancelled'];

// ─── Bookings Screen ──────────────────────────────────────────────────────────
class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bookings',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.maroon,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage your venue reservations and event schedules.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: _FilterTabBar(
                  activeTab: _activeTab,
                  onTabChanged: (i) => setState(() => _activeTab = i),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              sliver: _activeTab == 0
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _BookingCard(booking: _bookings[i]),
                        ),
                        childCount: _bookings.length,
                      ),
                    )
                  : SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(tab: _filterTabs[_activeTab]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTabBar extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChanged;

  const _FilterTabBar({required this.activeTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.maroon.withOpacity(0.07), width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(
            _filterTabs.length,
            (i) => _FilterTab(
              label: _filterTabs[i],
              isActive: activeTab == i,
              onTap: () => onTabChanged(i),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(right: 32),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: isActive ? AppColors.maroon : Colors.grey[400],
                ),
              ),
            ),
            if (isActive)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  decoration: const BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatefulWidget {
  final _Booking booking;
  const _BookingCard({required this.booking});

  @override
  State<_BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<_BookingCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final b = widget.booking;

    return GestureDetector(
      onTap: () {},
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.maroon.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: AppColors.maroon.withOpacity(_pressed ? 0.10 : 0.05),
              blurRadius: _pressed ? 40 : 20,
              offset: Offset(0, _pressed ? 10 : 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.network(
                b.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.maroon.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: b.statusColor,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              b.status.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.1,
                                color: AppColors.maroon,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.receipt_long_rounded, size: 13, color: Colors.grey[400]),
                          const SizedBox(width: 5),
                          Text(
                            '#${b.id}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    b.venue,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _InfoRow(icon: Icons.calendar_today_rounded, label: b.date),
                  const SizedBox(height: 8),
                  _InfoRow(icon: Icons.access_time_rounded, label: b.time),
                  const SizedBox(height: 18),
                  Divider(color: AppColors.maroon.withOpacity(0.06), height: 1),
                  const SizedBox(height: 14),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.maroon,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.maroon),
                      ],
                    ),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.maroon.withOpacity(0.4)),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String tab;
  const _EmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.maroon.withOpacity(0.06),
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              size: 32,
              color: AppColors.maroon.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No $tab bookings',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
