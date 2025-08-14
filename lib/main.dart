import 'package:connect_app/features/authentication/presentation/pages/additional_info_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/create_password_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/home_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/launch_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/login_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/onboarding_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/phone_registration_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/phone_verification_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/profile_photo_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/profile_selection_page.dart';
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
        GetPage(name: '/profile-selection', page: () => ProfileSelectionPage()),
        GetPage(
          name: '/phone-registration',
          page: () => PhoneRegistrationPage(),
        ),
        GetPage(name: '/verification', page: () => PhoneVerificationPage()),
        GetPage(name: '/create-password', page: () => CreatePasswordPage()),
        GetPage(name: '/additional-info', page: () => AdditionalInfoPage()),
        GetPage(name: '/profile-photo', page: () => ProfilePhotoPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      initialRoute: '/launch',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
