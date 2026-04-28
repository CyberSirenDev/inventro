import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/k_button.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({super.key});
  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  final _ctrl = TextEditingController();
  bool _searched = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 12), child: Row(children: [
          Expanded(child: Container(height: 52, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
            child: TextField(controller: _ctrl, onSubmitted: (_) => setState(() => _searched = true),
              decoration: const InputDecoration(hintText: 'Search products nearby...', prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary),
                border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, filled: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16))))),
        ])),
        // Filters
        SingleChildScrollView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: const [
            _Chip(icon: Icons.tune_rounded, label: 'Price Range'),
            SizedBox(width: 8),
            _Chip(icon: Icons.location_on_outlined, label: 'Distance'),
            SizedBox(width: 8),
            _Chip(icon: Icons.inventory_2_outlined, label: 'Available'),
          ])),
        const SizedBox(height: 12),
        Expanded(child: !_searched
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.search_rounded, size: 64, color: AppColors.textTertiary),
              const SizedBox(height: 16),
              const Text('Search for products near you', style: AppTextStyles.body),
              const SizedBox(height: 8),
              const Text('Try "coffee", "milk", or "shoes"', style: AppTextStyles.caption),
            ]))
          : _Results()),
      ])),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon; final String label;
  const _Chip({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: AppColors.textSecondary), const SizedBox(width: 6),
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
    ]));
}

class _Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Ethiopian Yirgacheffe Single Origin', 'sub': 'Light roast, 250g Whole Bean.', 'tag': 'BEST DEAL', 'dist': '0.5 km', 'price': r'$18.50', 'btn': 'View Item Details'},
      {'name': 'V60 Ceramic Dripper', 'sub': 'White ceramic, Size 02. Available at 3 locations.', 'dist': '1.2 km', 'price': r'$24.99', 'btn': 'Compare Prices'},
      {'name': 'Guatemalan Antigua', 'sub': 'MEDIUM ROAST', 'dist': '0.8 km', 'price': r'$16.00', 'btn': 'Compare Prices'},
      {'name': 'Cold Brew Concentrates', 'sub': 'MULTIPACK (4CT)', 'dist': '2.4 km', 'price': r'$32.50', 'btn': 'Compare Prices'},
    ];
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Padding(padding: const EdgeInsets.only(bottom: 16), child: Container(
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(height: 130, decoration: const BoxDecoration(color: Color(0xFF1A2A3A), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
              child: Center(child: Icon(Icons.inventory_2_rounded, color: Colors.white.withOpacity(.25), size: 56))),
            Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (item.containsKey('tag')) ...[
                Row(children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(6)),
                    child: Text(item['tag']!, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: .5))),
                  const SizedBox(width: 8),
                  const Icon(Icons.location_on_rounded, size: 12, color: AppColors.textTertiary),
                  Text(item['dist']!, style: AppTextStyles.caption),
                ]),
                const SizedBox(height: 6),
              ],
              Text(item['name']!, style: AppTextStyles.h2),
              const SizedBox(height: 4),
              Text(item['sub']!, style: AppTextStyles.caption),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('LOWEST PRICE', style: AppTextStyles.label),
                  Text(item['price']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('DISTANCE', style: AppTextStyles.label),
                  Text(item['dist']!, style: AppTextStyles.title),
                ]),
              ]),
              const SizedBox(height: 12),
              KButton(label: item['btn']!, onPressed: () {}, height: 44),
            ])),
          ]),
        ));
      },
    );
  }
}
