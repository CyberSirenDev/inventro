import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final List<_NavItem> items;

  const BottomNav({super.key, required this.currentIndex, required this.onTap, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, -4))]),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((e) {
              final idx = e.key;
              final item = e.value;
              final sel = idx == currentIndex;
              return GestureDetector(
                onTap: () => onTap(idx),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(sel ? item.activeIcon : item.icon, color: sel ? AppColors.primary : AppColors.textTertiary, size: 24),
                    const SizedBox(height: 3),
                    Text(item.label, style: TextStyle(fontSize: 9, fontWeight: sel ? FontWeight.w700 : FontWeight.w500, color: sel ? AppColors.primary : AppColors.textTertiary, letterSpacing: 0.3)),
                    if (sel) ...[const SizedBox(height: 3), Container(width: 4, height: 4, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))],
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
}

List<_NavItem> customerNavItems = [
  const _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'HOME'),
  const _NavItem(icon: Icons.search_outlined, activeIcon: Icons.search_rounded, label: 'SEARCH'),
  const _NavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart_rounded, label: 'CART'),
  const _NavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: 'ORDERS'),
  const _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'PROFILE'),
];

List<_NavItem> shopNavItems = [
  const _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'HOME'),
  const _NavItem(icon: Icons.search_outlined, activeIcon: Icons.search_rounded, label: 'SEARCH'),
  const _NavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart_rounded, label: 'CART'),
  const _NavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: 'ORDERS'),
  const _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'PROFILE'),
];
