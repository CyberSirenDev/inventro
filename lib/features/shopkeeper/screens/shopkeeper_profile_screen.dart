import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ShopkeeperProfileScreen extends StatelessWidget {
  const ShopkeeperProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(20,16,20,0), child: Row(children: [
        const CircleAvatar(radius: 20, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
        const SizedBox(width: 8),
        const Text('inventro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
        const SizedBox(width: 6),
        const Icon(Icons.notifications_active_rounded, color: AppColors.primary, size: 20),
      ])),

      // Shop banner
      Container(margin: const EdgeInsets.all(20), height: 120, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFFD63031), Color(0xFFE17055)])),
        child: Stack(children: [
          const Center(child: Text('SHOP', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 4))),
          Positioned(bottom: 12, left: 12, child: Row(children: [
            Container(width: 52, height: 52, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.storefront_rounded, color: AppColors.accent, size: 28)),
            const SizedBox(width: 10),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Artisan Pantry &\nCo.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
              Row(children: [Icon(Icons.verified_rounded, color: Colors.white, size: 12), SizedBox(width: 4), Text('Premium Local Merchant', style: TextStyle(fontSize: 11, color: Colors.white70))]),
            ]),
          ])),
        ])),

      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Contact Info', style: AppTextStyles.h2), const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(children: [
          _Cont(icon: Icons.email_outlined, text: 'hello@artisanpantry.com'),
          Divider(color: AppColors.border),
          _Cont(icon: Icons.phone_outlined, text: '+1 (555) 892-0431'),
          Divider(color: AppColors.border),
          _Cont(icon: Icons.location_on_outlined, text: '422 Market St, San Francisco, CA'),
        ])),

        const SizedBox(height: 14),
        const Text('Business Hours', style: AppTextStyles.h2), const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(children: [
          _Hours(day: 'Mon - Fri', h: '08:00 - 20:00'),
          const SizedBox(height: 8),
          _Hours(day: 'Saturday', h: '09:00 - 18:00'),
          const SizedBox(height: 8),
          _Hours(day: 'Sunday', h: 'Closed', hColor: AppColors.error),
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)), child: const Text('OPEN NOW', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: .5)))),
        ])),

        const SizedBox(height: 14),
        _Tile(icon: Icons.notifications_rounded, iconBg: AppColors.primarySurface, iconColor: AppColors.primary, title: 'Notifications', sub: 'Manage inventory alerts and order updates'),
        const SizedBox(height: 10),
        _Tile(icon: Icons.lock_rounded, iconBg: AppColors.accentLight, iconColor: AppColors.accent, title: 'Account Security', sub: 'Passwords, 2FA, and login history'),

        const SizedBox(height: 14),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Shop Preferences', style: AppTextStyles.h2),
          const Text('Edit All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ]),
        const SizedBox(height: 10),
        Container(decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(children: [
          _Pref(icon: Icons.language_outlined, label: 'Store Language', value: 'English (US)'),
          Divider(color: AppColors.border, indent: 56),
          _Pref(icon: Icons.credit_card_outlined, label: 'Payout Methods', value: 'Stripe •••• 4242'),
          Divider(color: AppColors.border, indent: 56),
          _Pref(icon: Icons.description_outlined, label: 'Tax Information', value: 'Verified W-9 on file'),
        ])),

        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.error.withOpacity(.3))),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Deactivate Merchant Account', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.error)),
              const Text('This will hide your inventory from all local searches.', style: AppTextStyles.caption),
            ])),
            const SizedBox(width: 10),
            OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: BorderSide(color: AppColors.error), minimumSize: const Size(100, 36), padding: const EdgeInsets.symmetric(horizontal: 14)), child: const Text('Deactivate')),
          ])),
        const SizedBox(height: 80),
      ])),
    ]))));
  }
}

class _Cont extends StatelessWidget {
  final IconData icon; final String text;
  const _Cont({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 7), child: Row(children: [
    Icon(icon, color: AppColors.primary, size: 18), const SizedBox(width: 12), Text(text, style: AppTextStyles.body),
  ]));
}

class _Hours extends StatelessWidget {
  final String day, h; final Color hColor;
  const _Hours({required this.day, required this.h, this.hColor = AppColors.textPrimary});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(day, style: AppTextStyles.body),
    Text(h, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: hColor)),
  ]);
}

class _Tile extends StatelessWidget {
  final IconData icon; final Color iconBg, iconColor; final String title, sub;
  const _Tile({required this.icon, required this.iconBg, required this.iconColor, required this.title, required this.sub});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 22)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTextStyles.title), Text(sub, style: AppTextStyles.caption)])),
      const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
    ]));
}

class _Pref extends StatelessWidget {
  final IconData icon; final String label, value;
  const _Pref({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => ListTile(leading: Icon(icon, color: AppColors.textSecondary, size: 20),
    title: Text(label, style: AppTextStyles.bodyPrimary), subtitle: Text(value, style: AppTextStyles.caption),
    trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary));
}
