import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
  late final AnimationController _textCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  late final AnimationController _barCtrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  late final AnimationController _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);

  late final Animation<double> _logoScale   = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut));
  late final Animation<double> _logoFade    = Tween(begin: 0.0, end: 1.0).animate(_logoCtrl);
  late final Animation<Offset> _textSlide   = Tween(begin: const Offset(0, .4), end: Offset.zero).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic));
  late final Animation<double> _textFade    = Tween(begin: 0.0, end: 1.0).animate(_textCtrl);
  late final Animation<double> _barWidth    = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _barCtrl, curve: Curves.easeInOut));
  late final Animation<double> _pulse       = Tween(begin: .94, end: 1.06).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

  int _dots = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
    _run();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return false;
      setState(() => _dots = (_dots + 1) % 4);
      return true;
    });
  }

  Future<void> _run() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _textCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _barCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 2600));
    if (mounted) Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void dispose() {
    _logoCtrl.dispose(); _textCtrl.dispose(); _barCtrl.dispose(); _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: Stack(children: [
        // decorative circles
        Positioned(top: -80, right: -60, child: _circle(280, .05)),
        Positioned(bottom: 120, left: -100, child: _circle(320, .04)),
        // watermark icon
        Positioned.fill(child: Center(child: Opacity(opacity: .05, child: const Icon(Icons.inventory_2_rounded, size: 320, color: Colors.white)))),

        SafeArea(child: Column(children: [
          const Spacer(flex: 2),
          // Logo
          AnimatedBuilder(animation: Listenable.merge([_logoCtrl, _pulseCtrl]), builder: (_, child) =>
            FadeTransition(opacity: _logoFade, child: Transform.scale(scale: _logoScale.value,
              child: Transform.scale(scale: _pulse.value, child: child))),
            child: Container(width: 100, height: 100,
              decoration: BoxDecoration(color: Colors.white.withOpacity(.15), borderRadius: BorderRadius.circular(28)),
              child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 52))),
          const SizedBox(height: 36),
          // Text
          SlideTransition(position: _textSlide, child: FadeTransition(opacity: _textFade,
            child: Column(children: [
              const Text('inventro', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -2, height: 1.1)),
              const SizedBox(height: 10),
              Text('Find it nearby. Instantly.', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(.72), fontWeight: FontWeight.w400)),
            ]))),
          const Spacer(flex: 3),
          // Progress
          Padding(padding: const EdgeInsets.fromLTRB(40, 0, 40, 12), child:
            AnimatedBuilder(animation: _barCtrl, builder: (_, __) =>
              ClipRRect(borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(value: _barWidth.value, minHeight: 3,
                  backgroundColor: Colors.white.withOpacity(.2), valueColor: const AlwaysStoppedAnimation(Colors.white))))),
          // Chip
          Container(margin: const EdgeInsets.only(bottom: 52),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.14), borderRadius: BorderRadius.circular(40)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.location_on_rounded, color: Colors.white, size: 15),
              const SizedBox(width: 7),
              Text('SCANNING LOCAL INVENTORY${'.' * _dots}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.1)),
            ])),
        ])),
      ]),
    );
  }

  Widget _circle(double size, double opacity) => Container(width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(opacity)));
}
