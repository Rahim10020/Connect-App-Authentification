import 'package:connect_app/core/bindings/app_bindings.dart';
import 'package:connect_app/core/middleware/auth_middleware.dart';
import 'package:connect_app/features/authentication/presentation/pages/additional_info_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/create_password_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/home_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/launch_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/login_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/onboarding_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/email_registration_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/verification_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/profile_photo_page.dart';
import 'package:connect_app/features/authentication/presentation/pages/profile_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser GetStorage
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connect App',
      debugShowCheckedModeBanner: false,

      // Initialiser les bindings au démarrage
      initialBinding: AppBindings(),

      home: LaunchPage(),

      getPages: [
        // Pages publiques (accessibles sans authentification)
        GetPage(
          name: '/launch',
          page: () => LaunchPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/onboarding',
          page: () => OnboardingPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/profile-selection',
          page: () => ProfileSelectionPage(),
          middlewares: [GuestMiddleware()],
        ),

        GetPage(
          name: '/email-registration',
          page: () => EmailRegistrationPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/verification',
          page: () => VerificationPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/create-password',
          page: () => CreatePasswordPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/additional-info',
          page: () => AdditionalInfoPage(),
          middlewares: [GuestMiddleware()],
        ),
        GetPage(
          name: '/profile-photo',
          page: () => ProfilePhotoPage(),
          middlewares: [GuestMiddleware()],
        ),

        // Pages privées (nécessitent une authentification)
        GetPage(
          name: '/home',
          page: () => HomePage(),
          middlewares: [AuthMiddleware(), VerificationMiddleware()],
        ),
      ],

      initialRoute: '/launch',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
