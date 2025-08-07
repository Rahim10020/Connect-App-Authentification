import 'package:connect_app/features/authentication/presentation/pages/launch_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/login_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connect App',
      debugShowCheckedModeBanner: false,
      home: LaunchPage(),
      getPages: [
        GetPage(name: '/launch', page: () => LaunchPage()),
        GetPage(name: '/onboarding', page: () => OnboardingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
      initialRoute: '/launch',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
