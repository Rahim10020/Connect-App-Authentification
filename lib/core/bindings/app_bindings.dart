import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialiser le contrôleur d'authentification
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
