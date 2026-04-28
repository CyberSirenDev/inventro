import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/bottom_nav.dart';
import 'customer_search_screen.dart';
import 'customer_profile_screen.dart';
import '../../orders/screens/cart_screen.dart';
import '../../orders/screens/customer_orders_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _idx = 0;
  late final List<Widget> _screens = [
    const _HomeTab(), const CustomerSearchScreen(), const CartScreen(), const CustomerOrdersScreen(), const CustomerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: BottomNav(currentIndex: _idx, onTap: (i) => setState(() => _idx = i), items: customerNavItems),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: CustomScrollView(slivers: [
        // Header
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Row(children: [
          const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
          const Expanded(child: Center(child: Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)))),
          IconButton(icon: const Icon(Icons.notifications_rounded), color: AppColors.textPrimary, onPressed: () {}),
        ]))),

        // Search
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 14, 20, 0), child:
          Container(height: 52, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 8)]),
            child: Row(children: [
              const SizedBox(width: 14),
              const Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 22),
              const SizedBox(width: 10),
              const Text('Search products nearby...', style: AppTextStyles.body),
            ])))),

        // Categories
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), child: Row(children: [
          _Cat(icon: Icons.shopping_cart_rounded, label: 'Groceries', color: AppColors.primary, bg: AppColors.primarySurface),
          const SizedBox(width: 12),
          _Cat(icon: Icons.egg_rounded, label: 'Dairy', color: AppColors.accent, bg: AppColors.accentLight),
          const SizedBox(width: 12),
          _Cat(icon: Icons.eco_rounded, label: 'Vegetables', color: AppColors.success, bg: AppColors.successLight),
        ]))),

        // Nearby Shops title
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 26, 20, 0), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text('Nearby Shops', style: AppTextStyles.h1), Text('View Map', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13))],
        ))),

        // Shops horizontal list
        SliverToBoxAdapter(child: SizedBox(height: 196, child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          children: const [
            _ShopCard(name: 'Central Market', dist: '0.4 miles', hours: 'Open until 9 PM', rating: '4.8', tags: ['ORGANIC', 'FRESH']),
            SizedBox(width: 12),
            _ShopCard(name: 'Green Leaf', dist: '1.2 miles', hours: 'Open until 8 PM', rating: '4.6', tags: ['ECO', 'LOCAL']),
            SizedBox(width: 12),
            _ShopCard(name: 'Daily Fresh', dist: '0.8 miles', hours: 'Open 24/7', rating: '4.3', tags: ['FRESH', '24H']),
          ],
        ))),

        // Best prices title
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 26, 20, 0), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Best Prices Near You', style: AppTextStyles.h1),
              const Text('Prices tracked from 24 local stores', style: AppTextStyles.caption),
            ]),
            Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 20)),
          ],
        ))),

        // Product list
        SliverPadding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 100), sliver: SliverList(delegate: SliverChildListDelegate([
          const _ProductCard(name: 'Organic Hass Avocados', stores: '12', store: 'CENTRAL MARKET', price: r'$1.20', unit: '/ea', status: 'STOCK LOW', sColor: AppColors.warning, sBg: AppColors.warningLight),
          const SizedBox(height: 12),
          const _ProductCard(name: 'Whole Grass-Fed Milk', stores: '8', store: 'GREEN LEAF', price: r'$3.50', unit: '/gal', status: 'IN STOCK', sColor: AppColors.success, sBg: AppColors.successLight),
          const SizedBox(height: 12),
          const _ProductCard(name: 'Mixed Bell Peppers', stores: '15', store: 'DAILY FRESH', price: r'$0.85', unit: '/ea', status: 'IN STOCK', sColor: AppColors.success, sBg: AppColors.successLight),
          const SizedBox(height: 12),
          const _ProductCard(name: 'Fresh Berry Mix', stores: '5', store: 'BOUTIQUE PANTRY', price: r'$4.99', unit: '/pk', status: 'PRICE DROP', sColor: AppColors.error, sBg: AppColors.errorLight),
        ]))),
      ])),
    );
  }
}

class _Cat extends StatelessWidget {
  final IconData icon; final String label; final Color color, bg;
  const _Cat({required this.icon, required this.label, required this.color, required this.bg});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 8)]),
    child: Column(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 22)),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
    ]));
}

class _ShopCard extends StatelessWidget {
  final String name, dist, hours, rating;
  final List<String> tags;
  const _ShopCard({required this.name, required this.dist, required this.hours, required this.rating, required this.tags});
  @override
  Widget build(BuildContext context) => Container(width: 196,
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8)]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(children: [
        Container(height: 100, decoration: const BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: const Center(child: Icon(Icons.storefront_rounded, color: AppColors.primary, size: 48))),
        Positioned(top: 8, right: 8, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.warning, borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.star_rounded, color: Colors.white, size: 11), const SizedBox(width: 2),
            Text(rating, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ]))),
      ]),
      Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: AppTextStyles.title),
        const SizedBox(height: 2),
        Text('$dist • $hours', style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 6),
        Row(children: tags.map((t) => Container(
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(5)),
          child: Text(t, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textSecondary)))).toList()),
      ])),
    ]));
}

class _ProductCard extends StatelessWidget {
  final String name, stores, store, price, unit, status;
  final Color sColor, sBg;
  const _ProductCard({required this.name, required this.stores, required this.store, required this.price, required this.unit, required this.status, required this.sColor, required this.sBg});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 8)]),
    child: Row(children: [
      Container(width: 78, height: 78, decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.inventory_2_rounded, color: AppColors.primary.withOpacity(.35), size: 36)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text(name, style: AppTextStyles.title, maxLines: 2, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 6),
          Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: sBg, borderRadius: BorderRadius.circular(6)),
            child: Text(status, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: sColor, letterSpacing: .3))),
        ]),
        const SizedBox(height: 3),
        Text('Found in $stores stores', style: AppTextStyles.caption),
        const SizedBox(height: 3),
        Text('CHEAPEST AT $store', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: .5)),
        const SizedBox(height: 6),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RichText(text: TextSpan(children: [TextSpan(text: price, style: AppTextStyles.price), TextSpan(text: unit, style: AppTextStyles.caption)])),
          Container(width: 32, height: 32, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 18)),
        ]),
      ])),
    ]));
}
