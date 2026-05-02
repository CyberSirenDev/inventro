import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ShopkeeperInventoryScreen extends StatelessWidget {
  const ShopkeeperInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Apex Runner 2.0', 'sku': 'RUN-APX-001', 'stock': 84, 'status': 'high'},
      {'name': 'Chronos Minimalist', 'sku': 'WTC-CHR-42MM', 'stock': 5, 'status': 'low'},
      {'name': 'Studio-Pro Wireless', 'sku': 'AUD-STP-WL', 'stock': 212, 'status': 'high'},
      {'name': 'Urban Sneaker Pro', 'sku': 'SNK-URB-001', 'stock': 0, 'status': 'out'},
      {'name': 'Canvas Backpack', 'sku': 'BAG-CNV-LG', 'stock': 33, 'status': 'medium'},
    ];

    return Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,16,20,0), child: Row(children: [
        const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
        const Expanded(child: Center(child: Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)))),
        const Icon(Icons.notifications_rounded, color: AppColors.primary),
      ]))),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,20,20,0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Inventory Management', style: AppTextStyles.display),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: Container(height: 52, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
            child: const Row(children: [SizedBox(width: 14), Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 20), SizedBox(width: 8), Text('Search products, SKUs, or cat', style: AppTextStyles.body)]))),
          const SizedBox(width: 10),
          Container(width: 52, height: 52, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.tune_rounded, color: AppColors.primary)),
        ]),
        const SizedBox(height: 14),
        _Stat(label: 'TOTAL PRODUCTS', value: '1,284', badge: '+12%', badgeColor: AppColors.accent),
        const SizedBox(height: 10),
        _Stat(label: 'LOW STOCK ITEMS', value: '24', valueColor: AppColors.error, trail: const Icon(Icons.warning_rounded, color: AppColors.error, size: 28)),
        const SizedBox(height: 10),
        _Stat(label: 'INVENTORY VALUE', value: r'$42.5k', valueColor: AppColors.primary, trail: const Icon(Icons.trending_up_rounded, color: AppColors.success, size: 28)),
        const SizedBox(height: 22),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Active Stock', style: AppTextStyles.h1),
          const Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ]),
        const SizedBox(height: 12),
      ]))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(20,0,20,100), sliver: SliverList(delegate: SliverChildBuilderDelegate(
        (_, i) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _ProdCard(p: products[i])),
        childCount: products.length,
      ))),
    ])));
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color valueColor; final String? badge; final Color? badgeColor; final Widget? trail;
  const _Stat({required this.label, required this.value, this.valueColor = AppColors.textPrimary, this.badge, this.badgeColor, this.trail});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: valueColor, letterSpacing: -.5)),
      ]),
      if (badge != null) Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: badgeColor!.withOpacity(.15), borderRadius: BorderRadius.circular(8)), child: Text(badge!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: badgeColor))),
      if (trail != null) trail!,
    ]));
}

class _ProdCard extends StatelessWidget {
  final Map<String, dynamic> p;
  const _ProdCard({required this.p});
  @override
  Widget build(BuildContext context) {
    final st = p['status'] as String;
    Color sc, sb; String sl;
    switch(st) {
      case 'high': sc = AppColors.success; sb = AppColors.successLight; sl = '${p['stock']} IN STOCK'; break;
      case 'low': sc = AppColors.accent; sb = AppColors.accentLight; sl = '${p['stock']} IN STOCK'; break;
      case 'out': sc = AppColors.error; sb = AppColors.errorLight; sl = 'OUT OF STOCK'; break;
      default: sc = AppColors.primary; sb = AppColors.primarySurface; sl = '${p['stock']} IN STOCK';
    }
    return Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(width: 58, height: 58, decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.inventory_2_rounded, color: AppColors.primary.withOpacity(.35), size: 26)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p['name'] as String, style: AppTextStyles.title),
          Text('SKU: ${p['sku']}', style: AppTextStyles.caption),
          const SizedBox(height: 6),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: sb, borderRadius: BorderRadius.circular(6)),
            child: Text(sl, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: sc, letterSpacing: .3))),
        ])),
        const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
      ]));
  }
}
