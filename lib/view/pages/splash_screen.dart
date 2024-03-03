import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';
import '../../router/route.dart';
import 'auth_pages/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextPage();
    super.initState();
  }

  Future<void> _navigateToNextPage() async =>
      Future.delayed(const Duration(seconds: 2))
          .then((_) => pushReplacementTo(context, const WelcomePage()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashScreen),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
