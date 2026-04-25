import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ─── Profile Screen ───────────────────────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileHeaderCard(),
              const SizedBox(height: 24),
              const _PaymentCard(),
              const SizedBox(height: 16),
              const _NotificationCard(),
              const SizedBox(height: 16),
              const _SupportCard(),
              const SizedBox(height: 16),
              const _LogoutButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Profile Header Card ──────────────────────────────────────────────────────
class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.maroon.withOpacity(0.07),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: AppColors.maroon.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cream,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Arjun Sharma',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'arjun.sharma@example.com  •  +91 98765 43210',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _PrimaryButton(
                        label: 'Edit Profile',
                        icon: Icons.edit_rounded,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OutlineButton(
                        label: 'Go Premium',
                        icon: Icons.workspace_premium_rounded,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.maroon,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.maroon.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.maroon, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppColors.maroon),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.maroon,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _SettingsCard({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.maroon.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: AppColors.maroon.withOpacity(0.05),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(22),
        child: child,
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const _IconBox({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: iconColor, size: 26),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final IconData? icon;

  const _Tag({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.maroon.withOpacity(0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: AppColors.maroon),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _IconBox(
            icon: Icons.credit_card_rounded,
            bgColor: Color(0xFFFFF3CC),
            iconColor: AppColors.maroon,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment Methods',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey[300],
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Manage your saved cards and preferred payment options.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const _Tag(
                  label: '2 Saved Cards',
                  icon: Icons.account_balance_wallet_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _IconBox(
            icon: Icons.notifications_rounded,
            bgColor: Color(0xFFF9E8EC),
            iconColor: AppColors.red,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey[300],
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Control how you receive updates about your bookings and events.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    _Tag(label: 'Email'),
                    SizedBox(width: 8),
                    _Tag(label: 'SMS'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.maroon.withOpacity(0.06),
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              size: 36,
              color: AppColors.maroon,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Help & Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Need assistance? Our support team is here for you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact Us',
                style: TextStyle(
                  color: AppColors.maroon,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right_rounded, color: AppColors.maroon, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatefulWidget {
  const _LogoutButton();

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) => setState(() => _hovered = false),
      onTapCancel: () => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFFFFF0F0) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.maroon.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: AppColors.maroon.withOpacity(0.05),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSlide(
              offset: _hovered ? const Offset(-0.15, 0) : Offset.zero,
              duration: const Duration(milliseconds: 180),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Logout',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
