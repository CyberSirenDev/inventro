import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/k_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> items = [
    {'name': 'Urban Chronograph', 'shop': 'Stockholm Design House', 'price': 185.0, 'qty': 1, 'drop': false},
    {'name': 'Studio-Z Wireless', 'shop': 'Acoustic Labs', 'price': 299.0, 'qty': 1, 'drop': true},
  ];

  double get sub => items.fold(0.0, (s, i) => s + (i['price'] as double) * (i['qty'] as int));
  double get tax => sub * 0.08;
  double get total => sub + tax;

  void _qty(int i, int d) => setState(() {
    final n = (items[i]['qty'] as int) + d;
    if (n <= 0) items.removeAt(i); else items[i]['qty'] = n;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Row(children: [
          const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
          const Expanded(child: Center(child: Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)))),
          IconButton(icon: const Icon(Icons.notifications_rounded), onPressed: () {}),
        ])),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Your Basket', style: AppTextStyles.display),
          const SizedBox(height: 4),
          const Text('Review your curated selection from local boutiques.', style: AppTextStyles.body),
          const SizedBox(height: 20),

          ...items.asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _CartItem(
            item: e.value,
            onDec: () => _qty(e.key, -1),
            onInc: () => _qty(e.key, 1),
            onDel: () => setState(() => items.removeAt(e.key)),
          ))),

          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(children: [
            const Align(alignment: Alignment.centerLeft, child: Text('Order Summary', style: AppTextStyles.h2)),
            const SizedBox(height: 16),
            _Row(label: 'Subtotal', value: '\$${sub.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            _Row(label: 'Local Delivery', value: 'FREE', vColor: AppColors.accent),
            const SizedBox(height: 10),
            _Row(label: 'Taxes', value: '\$${tax.toStringAsFixed(2)}'),
            Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Divider(color: AppColors.border)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Total', style: AppTextStyles.h2),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('ESTIMATED TOTAL', style: AppTextStyles.label),
                Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.primary)),
              ]),
            ]),
          ])),
          const SizedBox(height: 20),
          KButton(label: 'Place Order', onPressed: () {}),
          const SizedBox(height: 12),
          Center(child: RichText(textAlign: TextAlign.center, text: TextSpan(style: AppTextStyles.caption, children: [
            const TextSpan(text: "By placing your order, you agree to inventro's "),
            TextSpan(text: 'Terms of Service', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12, decoration: TextDecoration.underline)),
          ]))),
        ]))),
      ])),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDec, onInc, onDel;
  const _CartItem({required this.item, required this.onDec, required this.onInc, required this.onDel});

  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Container(width: 78, height: 78, decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 36)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: Text(item['name'] as String, style: AppTextStyles.title)),
          GestureDetector(onTap: onDel, child: const Icon(Icons.delete_outline_rounded, color: AppColors.textTertiary, size: 20)),
        ]),
        const SizedBox(height: 3),
        Text(item['shop'] as String, style: AppTextStyles.caption),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              IconButton(onPressed: onDec, icon: const Icon(Icons.remove, size: 15), visualDensity: VisualDensity.compact),
              Text('${item['qty']}', style: AppTextStyles.title),
              IconButton(onPressed: onInc, icon: const Icon(Icons.add, size: 15), visualDensity: VisualDensity.compact),
            ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if (item['drop'] as bool) const Text('PRICE DROP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.accent, letterSpacing: .5)),
            Text('\$${(item['price'] as double).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: (item['drop'] as bool) ? AppColors.primary : AppColors.textPrimary)),
          ]),
        ]),
      ])),
    ]));
}

class _Row extends StatelessWidget {
  final String label, value; final Color? vColor;
  const _Row({required this.label, required this.value, this.vColor});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: AppTextStyles.body),
    Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: vColor ?? AppColors.textPrimary)),
  ]);
}
