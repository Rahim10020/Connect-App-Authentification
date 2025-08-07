import 'package:connect_app/core/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes puis naviguer vers onboarding
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const LogoWidget(size: 80),
            const Spacer(),
            const LogoWidget(size: 40, showText: true),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
