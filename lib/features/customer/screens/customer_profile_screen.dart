import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const CircleAvatar(radius: 28, backgroundColor: AppColors.primarySurface, child: Icon(Icons.person_rounded, color: AppColors.primary, size: 28)),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Alex Johnson', style: AppTextStyles.h2),
            Text('alex@example.com', style: AppTextStyles.caption),
          ]),
          const Spacer(),
          const Icon(Icons.notifications_rounded, color: AppColors.primary),
        ]),
        const SizedBox(height: 26),
        _Section(title: 'Account', items: const [
          _Item(icon: Icons.person_outline_rounded, label: 'Edit Profile'),
          _Item(icon: Icons.location_on_outlined, label: 'Saved Addresses'),
          _Item(icon: Icons.payment_outlined, label: 'Payment Methods'),
        ]),
        const SizedBox(height: 14),
        _Section(title: 'Preferences', items: const [
          _Item(icon: Icons.notifications_outlined, label: 'Notifications'),
          _Item(icon: Icons.language_outlined, label: 'Language'),
          _Item(icon: Icons.dark_mode_outlined, label: 'Appearance'),
        ]),
        const SizedBox(height: 14),
        _Section(title: 'Support', items: const [
          _Item(icon: Icons.help_outline_rounded, label: 'Help Center'),
          _Item(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy'),
          _Item(icon: Icons.description_outlined, label: 'Terms of Service'),
        ]),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.errorLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.error.withOpacity(.3))),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.error, fontSize: 15)),
              const Text('You will be redirected to login.', style: AppTextStyles.caption),
            ])),
            OutlinedButton(onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.error, side: BorderSide(color: AppColors.error), minimumSize: const Size(80, 36), padding: const EdgeInsets.symmetric(horizontal: 16)),
              child: const Text('Sign Out')),
          ])),
        const SizedBox(height: 80),
      ]))),
    );
  }
}

class _Section extends StatelessWidget {
  final String title; final List<Widget> items;
  const _Section({required this.title, required this.items});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: AppTextStyles.title), const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)), child: Column(children: items)),
  ]);
}

class _Item extends StatelessWidget {
  final IconData icon; final String label;
  const _Item({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppColors.primary, size: 22),
    title: Text(label, style: AppTextStyles.bodyPrimary),
    trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
    onTap: () {},
  );
}
