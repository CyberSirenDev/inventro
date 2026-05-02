import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/bottom_nav.dart';
import 'shopkeeper_inventory_screen.dart';
import 'shopkeeper_orders_screen.dart';
import 'shopkeeper_profile_screen.dart';
import '../../customer/screens/customer_search_screen.dart';

class ShopkeeperHomeScreen extends StatefulWidget {
  const ShopkeeperHomeScreen({super.key});
  @override
  State<ShopkeeperHomeScreen> createState() => _ShopkeeperHomeScreenState();
}

class _ShopkeeperHomeScreenState extends State<ShopkeeperHomeScreen> {
  int _idx = 0;
  late final List<Widget> _screens = [
    const _DashTab(), const CustomerSearchScreen(), const ShopkeeperInventoryScreen(), const ShopkeeperOrdersScreen(), const ShopkeeperProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _idx, children: _screens),
    bottomNavigationBar: BottomNav(currentIndex: _idx, onTap: (i) => setState(() => _idx = i), items: shopNavItems),
    floatingActionButton: _idx == 2 ? FloatingActionButton(onPressed: () {}, backgroundColor: AppColors.primary, child: const Icon(Icons.add, color: Colors.white)) : null,
  );
}

class _DashTab extends StatelessWidget {
  const _DashTab();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,16,20,0), child: Row(children: [
        const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
        const SizedBox(width: 10),
        const Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
        const Spacer(),
        const Icon(Icons.notifications_rounded, color: AppColors.primary),
      ]))),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,20,20,0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Shop Overview', style: AppTextStyles.display),
        const Text("Welcome back, Merchant. Here's what's happening today.", style: AppTextStyles.body),
        const SizedBox(height: 20),

        _StatCard(icon: Icons.inventory_2_rounded, iconBg: AppColors.primarySurface, iconColor: AppColors.primary, label: 'TOTAL PRODUCTS', value: '1,284', sub: '↗ 12% from last month', subColor: AppColors.success),
        const SizedBox(height: 12),
        _StatCard(icon: Icons.storefront_rounded, iconBg: AppColors.accentLight, iconColor: AppColors.accent, label: 'ORDERS TODAY', value: '42', sub: '⚡ 8 high priority', subColor: AppColors.accent),
        const SizedBox(height: 12),

        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)), child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.white.withOpacity(.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.attach_money_rounded, color: Colors.white, size: 24)),
          const SizedBox(width: 14),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('DAILY REVENUE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white70, letterSpacing: .5)),
            Text(r'$3,842.00', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -.5)),
            Text('↗ 24% vs yesterday', style: TextStyle(fontSize: 12, color: Colors.white70)),
          ]),
        ])),
        const SizedBox(height: 24),

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Recent Activity', style: AppTextStyles.h1),
          const Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ]),
        const SizedBox(height: 12),

        _ActCard(icon: Icons.local_shipping_rounded, iconBg: AppColors.primarySurface, iconColor: AppColors.primary, title: 'Order #8492 Shipped', sub: 'To Michael R. • 2 mins ago', right: '+\$142.00', rightColor: AppColors.success),
        const SizedBox(height: 10),
        _ActCard(icon: Icons.shopping_cart_rounded, iconBg: AppColors.successLight, iconColor: AppColors.success, title: 'New Order Received', sub: 'From Sarah L. • 15 mins ago', right: '+\$89.50', rightColor: AppColors.success),
        const SizedBox(height: 10),
        _ActCard(icon: Icons.warning_rounded, iconBg: AppColors.warningLight, iconColor: AppColors.warning, title: 'Low Stock Alert', sub: 'Organic Espresso Beans • 1hr ago', right: 'RESTOCK', rightColor: Colors.white, rightBg: AppColors.accent),
        const SizedBox(height: 10),
        _ActCard(icon: Icons.person_add_rounded, iconBg: AppColors.primarySurface, iconColor: AppColors.primary, title: 'New Customer Registered', sub: 'David K. • 3 hrs ago', right: 'View', rightColor: AppColors.primary),

        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Inventory Health', style: AppTextStyles.h2),
              const SizedBox(height: 4),
              const Text('Your stock levels are 85% optimal. 12 items need attention this week.', style: AppTextStyles.caption),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40), backgroundColor: AppColors.textPrimary), child: const Text('Run Audit')),
            ])),
            Icon(Icons.bar_chart_rounded, size: 60, color: AppColors.textTertiary.withOpacity(.3)),
          ])),

        const SizedBox(height: 20),
        const Text('Top Performing Products', style: AppTextStyles.h1),
        const SizedBox(height: 12),
        _PerfRow(name: 'Matte Black Brewer', pct: .92),
        const SizedBox(height: 10),
        _PerfRow(name: 'Heritage Journal', pct: .65),
        const SizedBox(height: 100),
      ]))),
    ])));
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon; final Color iconBg, iconColor, subColor;
  final String label, value, sub;
  const _StatCard({required this.icon, required this.iconBg, required this.iconColor, required this.label, required this.value, required this.sub, required this.subColor});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 22)),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: AppTextStyles.label),
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -.5)),
        Text(sub, style: TextStyle(fontSize: 12, color: subColor, fontWeight: FontWeight.w600)),
      ]),
    ]));
}

class _ActCard extends StatelessWidget {
  final IconData icon; final Color iconBg, iconColor, rightColor;
  final String title, sub, right; final Color? rightBg;
  const _ActCard({required this.icon, required this.iconBg, required this.iconColor, required this.title, required this.sub, required this.right, required this.rightColor, this.rightBg});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iconColor, size: 20)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.title),
        Text(sub, style: AppTextStyles.caption),
      ])),
      rightBg != null
        ? Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: rightBg, borderRadius: BorderRadius.circular(8)), child: Text(right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: rightColor)))
        : Text(right, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: rightColor)),
    ]));
}

class _PerfRow extends StatelessWidget {
  final String name; final double pct;
  const _PerfRow({required this.name, required this.pct});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 22)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: AppTextStyles.title),
        const SizedBox(height: 6),
        ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: pct, minHeight: 6, backgroundColor: AppColors.background, valueColor: const AlwaysStoppedAnimation(AppColors.accent))),
      ])),
      const SizedBox(width: 12),
      Text('${(pct*100).toInt()}%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
    ]));
}
