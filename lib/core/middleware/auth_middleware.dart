// lib/core/middleware/auth_middleware.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Si l'utilisateur n'est pas connecté, rediriger vers onboarding
    if (!authController.isLoggedIn) {
      return const RouteSettings(name: '/onboarding');
    }

    return null;
  }
}

class GuestMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Si l'utilisateur est déjà connecté, rediriger vers la page d'accueil
    if (authController.isLoggedIn) {
      return const RouteSettings(name: '/home');
    }

    return null;
  }
}

class VerificationMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Si l'utilisateur est connecté mais pas vérifié, rediriger vers vérification
    // Mais seulement si on n'est pas déjà sur la page de vérification
    if (authController.isLoggedIn &&
        !authController.isUserVerified &&
        route != '/verification') {
      return const RouteSettings(name: '/verification');
    }

    return null;
  }
}
