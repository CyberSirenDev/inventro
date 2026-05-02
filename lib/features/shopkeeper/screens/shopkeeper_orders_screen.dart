import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ShopkeeperOrdersScreen extends StatefulWidget {
  const ShopkeeperOrdersScreen({super.key});
  @override
  State<ShopkeeperOrdersScreen> createState() => _ShopkeeperOrdersScreenState();
}

class _ShopkeeperOrdersScreenState extends State<ShopkeeperOrdersScreen> {
  int _filter = 0;
  final _filters = ['All Orders', 'Incoming', 'Processing', 'Shipped'];
  final _orders = [
    {'id': 'ORD-8829', 'customer': 'Marcello G.', 'items': 2, 'amount': r'$124.00', 'method': 'Credit Card', 'status': 'NEW ORDER', 'sc': 'accent', 'action': 'ar'},
    {'id': 'ORD-8827', 'customer': 'Sarah Jenkins', 'items': 1, 'amount': r'$89.50', 'method': '', 'status': 'PROCESSING', 'sc': 'primary', 'action': 'drop'},
    {'id': 'ORD-8825', 'customer': 'David Chen', 'items': 3, 'amount': r'$299.00', 'method': 'Store Pickup', 'status': 'READY', 'sc': 'success', 'action': 'fulfill'},
    {'id': 'ORD-8820', 'customer': 'Elena Ross', 'items': 1, 'amount': r'$175.25', 'method': 'Home Delivery', 'status': 'NEW ORDER', 'sc': 'accent', 'action': 'ar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,16,20,0), child: Row(children: [
        const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
        const Expanded(child: Center(child: Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)))),
        const Icon(Icons.notifications_rounded, color: AppColors.primary),
      ]))),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20,20,20,0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Orders Management', style: AppTextStyles.display),
        const Text('Manage your incoming shop requests and track fulfillment status.', style: AppTextStyles.body),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PEAK PERFORMANCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: .5)),
          Text('124', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -.5)),
          Text('Orders processed this week', style: AppTextStyles.caption),
        ])),
        const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(14)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('PENDING ACTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: .5)),
          Text('12', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -.5)),
          Text('Orders awaiting your approval', style: TextStyle(fontSize: 12, color: Colors.white70)),
        ])),
        const SizedBox(height: 16),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: _filters.asMap().entries.map((e) {
          final sel = e.key == _filter;
          return Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(onTap: () => setState(() => _filter = e.key),
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: sel ? AppColors.primary : AppColors.surface, borderRadius: BorderRadius.circular(20)),
              child: Text(e.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.textSecondary)))));
        }).toList())),
        const SizedBox(height: 14),
      ]))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(20,0,20,100), sliver: SliverList(delegate: SliverChildBuilderDelegate(
        (_, i) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _OrdCard(o: _orders[i])),
        childCount: _orders.length,
      ))),
    ])));
  }
}

Color _oc(String c) { switch(c){ case 'accent': return AppColors.accent; case 'success': return AppColors.success; default: return AppColors.primary; } }

class _OrdCard extends StatelessWidget {
  final Map<String, dynamic> o;
  const _OrdCard({required this.o});
  @override
  Widget build(BuildContext context) {
    final sc = o['sc'] as String;
    final act = o['action'] as String;
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(radius: 22, backgroundColor: AppColors.background, child: Icon(Icons.person_rounded, color: AppColors.textSecondary, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('#${o['id']}', style: AppTextStyles.title),
          Text('${o['customer']} • ${o['items']} items', style: AppTextStyles.caption),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: _oc(sc), borderRadius: BorderRadius.circular(8)),
          child: Text(o['status'] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: .3))),
      ]),
      const SizedBox(height: 12),
      if (act == 'drop') ...[
        const Text('UPDATE STATUS', style: AppTextStyles.label), const SizedBox(height: 6),
        Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(10)),
          child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Processing', style: AppTextStyles.bodyPrimary), Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
          ])), const SizedBox(height: 12),
      ],
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(o['amount'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: -.3)),
          if ((o['method'] as String).isNotEmpty) Text(o['method'] as String, style: AppTextStyles.caption),
        ]),
        if (act == 'drop') const Text('View details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
      ]),
      if (act == 'ar') ...[
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: const Size(0,44)), child: const Text('Accept'))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(minimumSize: const Size(0,44), foregroundColor: AppColors.error, side: const BorderSide(color: AppColors.error)), child: const Text('Reject'))),
        ]),
      ],
      if (act == 'fulfill') ...[
        const SizedBox(height: 12),
        OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44)), child: const Text('Complete Fulfillment')),
      ],
    ]));
  }
}
