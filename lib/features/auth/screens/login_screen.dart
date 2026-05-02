import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/k_button.dart';
import '../../../shared/widgets/k_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  bool _keep = false, _obscure = true, _loading = false;
  late final AnimationController _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<Offset> _slide = Tween(begin: const Offset(0, .25), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  late final Animation<double>  _fade  = Tween(begin: 0.0, end: 1.0).animate(_ctrl);

  @override
  void initState() { super.initState(); _ctrl.forward(); }
  @override
  void dispose() { _email.dispose(); _pass.dispose(); _ctrl.dispose(); super.dispose(); }

  Future<void> _login() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) { setState(() => _loading = false); Navigator.of(context).pushReplacementNamed('/role-select'); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [
        SafeArea(bottom: false, child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('inventro', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
            Container(width: 36, height: 36, decoration: const BoxDecoration(color: AppColors.textPrimary, shape: BoxShape.circle),
              child: const Icon(Icons.question_mark_rounded, color: Colors.white, size: 18)),
          ]),
        )),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SlideTransition(position: _slide, child: FadeTransition(opacity: _fade,
            child: Container(
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 24, offset: const Offset(0, 6))]),
              padding: const EdgeInsets.all(28),
              child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Welcome back', style: AppTextStyles.display),
                const SizedBox(height: 8),
                const Text('Sign in to manage your local inventory.', style: AppTextStyles.body),
                const SizedBox(height: 30),

                const Text('Email Address', style: AppTextStyles.title),
                const SizedBox(height: 8),
                KTextField(controller: _email, hint: 'alex@example.com', prefixIcon: Icons.email_outlined,
                  keyboard: TextInputType.emailAddress,
                  validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null),
                const SizedBox(height: 20),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Password', style: AppTextStyles.title),
                  GestureDetector(onTap: () {}, child: const Text('Forgot password?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
                ]),
                const SizedBox(height: 8),
                KTextField(controller: _pass, hint: '••••••••••••', prefixIcon: Icons.lock_outline_rounded,
                  obscure: _obscure, suffixIcon: _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  onSuffixTap: () => setState(() => _obscure = !_obscure),
                  validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null),
                const SizedBox(height: 16),

                GestureDetector(onTap: () => setState(() => _keep = !_keep),
                  child: Row(children: [
                    AnimatedContainer(duration: const Duration(milliseconds: 200), width: 22, height: 22,
                      decoration: BoxDecoration(color: _keep ? AppColors.primary : Colors.transparent, border: Border.all(color: _keep ? AppColors.primary : AppColors.border, width: 1.5), borderRadius: BorderRadius.circular(6)),
                      child: _keep ? const Icon(Icons.check, color: Colors.white, size: 14) : null),
                    const SizedBox(width: 10),
                    const Text('Keep me signed in', style: AppTextStyles.body),
                  ])),
                const SizedBox(height: 26),

                KButton(label: 'Login', onPressed: _login, isLoading: _loading),
                const SizedBox(height: 22),

                Row(children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(children: [
                      const Text('New user?  ', style: AppTextStyles.caption),
                      GestureDetector(onTap: () => Navigator.of(context).pushNamed('/signup'),
                        child: const Text('Sign up', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary))),
                    ])),
                  Expanded(child: Divider(color: AppColors.border)),
                ]),
                const SizedBox(height: 20),

                const Center(child: Text('OR CONTINUE WITH', style: AppTextStyles.label)),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _SocialBtn(color: const Color(0xFFEA4335), icon: Icons.g_mobiledata_rounded),
                  const SizedBox(width: 12),
                  _SocialBtn(color: const Color(0xFF00A4EF), icon: Icons.laptop_mac_rounded),
                ]),
                const SizedBox(height: 4),
              ])),
            ),
          )),
        )),
      ]),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final Color color; final IconData icon;
  const _SocialBtn({required this.color, required this.icon});
  @override
  Widget build(BuildContext context) => Container(width: 60, height: 52,
    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
    child: Icon(icon, color: color, size: 30));
}
