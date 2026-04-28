import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Row(children: [
          const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
          const Expanded(child: Center(child: Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)))),
          IconButton(icon: const Icon(Icons.notifications_rounded), onPressed: () {}),
        ]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 22, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Orders', style: AppTextStyles.display),
          const SizedBox(height: 4),
          const Text('Track your inventory acquisitions and deliveries.', style: AppTextStyles.body),
          const SizedBox(height: 20),

          // Active order
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(20)),
                  child: const Text('IN TRANSIT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: .5))),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('EST. DELIVERY', style: AppTextStyles.label),
                  const Text('Today, 4:30 PM', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary)),
                ]),
              ]),
              const SizedBox(height: 12),
              const Text('Order #INV-8821', style: AppTextStyles.h1),
              const SizedBox(height: 18),
              _OrderProgress(step: 2),
              const SizedBox(height: 18),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.inventory_2_rounded, color: AppColors.primary, size: 26)),
                  const SizedBox(width: 12),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Nike Air Max Pulse', style: AppTextStyles.title),
                    Text('Qty: 01 • Size: 42', style: AppTextStyles.caption),
                  ])),
                  const Text(r'$159.00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                ])),
            ])),

          const SizedBox(height: 26),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('History', style: AppTextStyles.h1),
            const Text('FILTER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: .5)),
          ]),
          const SizedBox(height: 12),
        ]))),

        SliverPadding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 100), sliver: SliverList(delegate: SliverChildListDelegate([
          _HistCard(id: 'INV-8790', status: 'DELIVERED', sc: 'success', date: 'OCT 24, 2023', items: 3, total: r'$412.50', icon: Icons.check_circle_rounded),
          const SizedBox(height: 10),
          _HistCard(id: 'INV-8755', status: 'ACCEPTED', sc: 'primary', date: 'OCT 22, 2023', items: 1, total: r'$89.00', icon: Icons.verified_rounded),
          const SizedBox(height: 10),
          _HistCard(id: 'INV-8742', status: 'PENDING', sc: 'warning', date: 'OCT 21, 2023', items: 5, total: r'$1,204.00', icon: Icons.pending_rounded),
        ]))),
      ])),
    );
  }
}

class _OrderProgress extends StatelessWidget {
  final int step;
  const _OrderProgress({required this.step});
  @override
  Widget build(BuildContext context) {
    final steps = ['PLACED', 'PACKED', 'TRANSIT', 'ARRIVAL'];
    final icons = [Icons.check_circle_rounded, Icons.inventory_2_rounded, Icons.local_shipping_rounded, Icons.home_rounded];
    return Row(children: List.generate(steps.length * 2 - 1, (i) {
      if (i.isOdd) {
        final si = i ~/ 2;
        return Expanded(child: Container(height: 2, color: si < step ? AppColors.primary : AppColors.border));
      }
      final si = i ~/ 2;
      final done = si <= step;
      return Column(children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: done ? AppColors.primary : AppColors.background, shape: BoxShape.circle, border: Border.all(color: done ? AppColors.primary : AppColors.border, width: 2)),
          child: Icon(icons[si], color: done ? Colors.white : AppColors.textTertiary, size: 17)),
        const SizedBox(height: 4),
        Text(steps[si], style: TextStyle(fontSize: 9, fontWeight: si == step ? FontWeight.w700 : FontWeight.w500, color: si == step ? AppColors.primary : AppColors.textTertiary, letterSpacing: .3)),
      ]);
    }));
  }
}

Color _sc(String c) { switch(c) { case 'success': return AppColors.success; case 'warning': return AppColors.warning; default: return AppColors.primary; } }
Color _sb(String c) { switch(c) { case 'success': return AppColors.successLight; case 'warning': return AppColors.warningLight; default: return AppColors.primarySurface; } }

class _HistCard extends StatelessWidget {
  final String id, status, sc, date, total;
  final int items; final IconData icon;
  const _HistCard({required this.id, required this.status, required this.sc, required this.date, required this.items, required this.total, required this.icon});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(children: [
      Row(children: [
        CircleAvatar(radius: 22, backgroundColor: _sb(sc), child: Icon(icon, color: _sc(sc), size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$status • $date', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textTertiary, letterSpacing: .3)),
          Text('Order #$id', style: AppTextStyles.title),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: _sb(sc), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _sc(sc), letterSpacing: .3))),
      ]),
      const SizedBox(height: 8),
      Divider(color: AppColors.border),
      const SizedBox(height: 6),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('$items items • $total', style: AppTextStyles.body),
        Row(children: [const Text('DETAILS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: .3)), const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 18)]),
      ]),
    ]));
}
