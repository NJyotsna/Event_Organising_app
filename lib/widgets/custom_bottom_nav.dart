import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class NavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const NavTab(this.icon, this.activeIcon, this.label);
}

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<NavTab> tabs;
  final Future<void> Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.maroon.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              tabs.length,
              (i) => _NavItem(
                tab: tabs[i],
                isActive: selectedIndex == i,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(i);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final NavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.maroon.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? tab.activeIcon : tab.icon,
                key: ValueKey(isActive),
                color: isActive ? AppColors.maroon : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.maroon : Colors.grey[400],
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
