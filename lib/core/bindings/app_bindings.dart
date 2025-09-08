// lib/core/bindings/app_bindings.dart
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialiser le contrôleur d'authentification
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

// lib/core/bindings/auth_bindings.dart
class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
