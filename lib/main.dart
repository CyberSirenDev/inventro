import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/role_selection_screen.dart';
import 'features/customer/screens/customer_home_screen.dart';
import 'features/shopkeeper/screens/shopkeeper_home_screen.dart';

void main() => runApp(const InventoApp());

class InventoApp extends StatelessWidget {
  const InventoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inventro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/':              (_) => const SplashScreen(),
        '/login':         (_) => const LoginScreen(),
        '/signup':        (_) => const SignupScreen(),
        '/role-select':   (_) => const RoleSelectionScreen(),
        '/customer-home': (_) => const CustomerHomeScreen(),
        '/shop-home':     (_) => const ShopkeeperHomeScreen(),
      },
    );
  }
}
