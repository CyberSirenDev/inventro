import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/k_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> with SingleTickerProviderStateMixin {
  String? _role;
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);

  @override
  void initState() { super.initState(); _ctrl.forward(); }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _go() {
    if (_role == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a role'))); return; }
    Navigator.of(context).pushReplacementNamed(_role == 'customer' ? '/customer-home' : '/shop-home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: FadeTransition(opacity: _fade, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 48),
          const Text('How do you want to\nuse inventro?', textAlign: TextAlign.center, style: AppTextStyles.display),
          const SizedBox(height: 12),
          const Text('Choose your journey and start managing\nyour inventory with precision.', textAlign: TextAlign.center, style: AppTextStyles.body),
          const SizedBox(height: 36),

          _RoleCard(
            selected: _role == 'customer',
            tag: 'SHOPPING', tagColor: AppColors.accent,
            icon: Icons.person_outline_rounded, iconBg: AppColors.primarySurface, iconColor: AppColors.primary,
            title: 'Customer',
            desc: 'Browse products, track hyperlocal stock levels, and find the best deals in your neighborhood.',
            btnLabel: 'Continue as Customer',
            onTap: () => setState(() => _role = 'customer'),
            onBtn: () { setState(() => _role = 'customer'); _go(); },
          ),
          const SizedBox(height: 16),

          _RoleCard(
            selected: _role == 'shopkeeper',
            tag: 'BUSINESS', tagColor: AppColors.accent,
            icon: Icons.storefront_rounded, iconBg: AppColors.accentLight, iconColor: AppColors.accent,
            title: 'Shop Owner',
            desc: 'Manage inventory, track sales analytics, and connect with local customers in real-time.',
            btnLabel: 'Continue as Shop Owner',
            onTap: () => setState(() => _role = 'shopkeeper'),
            onBtn: () { setState(() => _role = 'shopkeeper'); _go(); },
          ),
        ]),
      ))),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final bool selected;
  final String tag; final Color tagColor;
  final IconData icon; final Color iconBg, iconColor;
  final String title, desc, btnLabel;
  final VoidCallback onTap, onBtn;

  const _RoleCard({required this.selected, required this.tag, required this.tagColor, required this.icon, required this.iconBg, required this.iconColor, required this.title, required this.desc, required this.btnLabel, required this.onTap, required this.onBtn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? AppColors.primary : Colors.transparent, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 12, offset: const Offset(0, 4))]),
      child: Stack(children: [
        Padding(padding: const EdgeInsets.all(22), child: Column(children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(18)), child: Icon(icon, color: iconColor, size: 32)),
          const SizedBox(height: 14),
          Text(title, style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: AppTextStyles.body),
          const SizedBox(height: 18),
          KButton(label: btnLabel, onPressed: onBtn, height: 48),
        ])),
        Positioned(top: 14, right: 14, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(6)),
          child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: .5)))),
      ]),
    ));
  }
}
