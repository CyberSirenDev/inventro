import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/k_button.dart';
import '../../../shared/widgets/k_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true, _obscureC = true, _agreed = false, _loading = false;

  @override
  void dispose() { _name.dispose(); _email.dispose(); _pass.dispose(); _confirm.dispose(); super.dispose(); }

  Future<void> _signup() async {
    if (!_form.currentState!.validate()) return;
    if (!_agreed) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please agree to Terms & Conditions'))); return; }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) { setState(() => _loading = false); Navigator.of(context).pushReplacementNamed('/role-select'); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('inventro'), leading: IconButton(icon: const Icon(Icons.arrow_back_ios_rounded), onPressed: () => Navigator.pop(context))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.all(28),
          child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Create account', style: AppTextStyles.display),
            const SizedBox(height: 8),
            const Text('Join inventro and discover local inventory.', style: AppTextStyles.body),
            const SizedBox(height: 30),

            const Text('Full Name', style: AppTextStyles.title), const SizedBox(height: 8),
            KTextField(controller: _name, hint: 'Alex Johnson', prefixIcon: Icons.person_outline_rounded,
              validator: (v) => v == null || v.isEmpty ? 'Enter your name' : null),
            const SizedBox(height: 18),

            const Text('Email Address', style: AppTextStyles.title), const SizedBox(height: 8),
            KTextField(controller: _email, hint: 'alex@example.com', prefixIcon: Icons.email_outlined,
              keyboard: TextInputType.emailAddress,
              validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null),
            const SizedBox(height: 18),

            const Text('Password', style: AppTextStyles.title), const SizedBox(height: 8),
            KTextField(controller: _pass, hint: 'Min 8 characters', prefixIcon: Icons.lock_outline_rounded,
              obscure: _obscure, suffixIcon: _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              onSuffixTap: () => setState(() => _obscure = !_obscure),
              validator: (v) => v == null || v.length < 8 ? 'Min 8 characters' : null),
            const SizedBox(height: 18),

            const Text('Confirm Password', style: AppTextStyles.title), const SizedBox(height: 8),
            KTextField(controller: _confirm, hint: 'Repeat password', prefixIcon: Icons.lock_outline_rounded,
              obscure: _obscureC, suffixIcon: _obscureC ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              onSuffixTap: () => setState(() => _obscureC = !_obscureC),
              validator: (v) => v != _pass.text ? 'Passwords do not match' : null),
            const SizedBox(height: 20),

            GestureDetector(onTap: () => setState(() => _agreed = !_agreed),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AnimatedContainer(duration: const Duration(milliseconds: 200), width: 22, height: 22,
                  decoration: BoxDecoration(color: _agreed ? AppColors.primary : Colors.transparent,
                    border: Border.all(color: _agreed ? AppColors.primary : AppColors.border, width: 1.5), borderRadius: BorderRadius.circular(6)),
                  child: _agreed ? const Icon(Icons.check, color: Colors.white, size: 14) : null),
                const SizedBox(width: 10),
                Expanded(child: RichText(text: TextSpan(style: AppTextStyles.body, children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(text: 'Terms & Conditions', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 14)),
                  const TextSpan(text: ' and '),
                  TextSpan(text: 'Privacy Policy', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 14)),
                ]))),
              ])),
            const SizedBox(height: 26),

            KButton(label: 'Create Account', onPressed: _signup, isLoading: _loading),
            const SizedBox(height: 18),

            Center(child: GestureDetector(onTap: () => Navigator.pop(context),
              child: RichText(text: const TextSpan(style: AppTextStyles.body, children: [
                TextSpan(text: 'Already have an account?  '),
                TextSpan(text: 'Sign in', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
              ])))),
          ])),
        ),
      ),
    );
  }
}
