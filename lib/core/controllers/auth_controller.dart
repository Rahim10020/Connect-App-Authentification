// lib/core/controllers/auth_controller.dart
import 'package:get/get.dart';
import '../models/auth_models.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // États observables
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  User? get currentUser => _currentUser.value;
  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => _isLoggedIn.value;
  String get errorMessage => _errorMessage.value;
  bool get isUserVerified => currentUser?.isVerified ?? false;

  @override
  void onInit() {
    super.onInit();
    print('🎯 AuthController initialisé');
    _checkAuthStatus();
  }

  /// Vérifier le statut d'authentification au démarrage
  void _checkAuthStatus() {
    print('🔍 Vérification du statut d\'authentification');
    final user = _authService.getCurrentUserFromStorage();
    final token = _authService.getToken();

    print('👤 Utilisateur depuis le stockage: ${user?.email}');
    print('🔑 Token depuis le stockage: ${token != null ? 'présent' : 'absent'}');

    if (user != null && token != null) {
      _currentUser.value = user;
      _isLoggedIn.value = true;
      print('✅ Utilisateur connecté restauré');
    } else {
      print('❌ Aucun utilisateur connecté trouvé');
    }
  }

  /// Effacer les messages d'erreur
  void clearError() {
    _errorMessage.value = '';
  }

  // =========================================================================
  // INSCRIPTION
  // =========================================================================

  /// Inscrire un nouvel utilisateur
  Future<bool> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String passwordConfirmation,
    String? phoneNumber,
    String? birthdayDate,
    String? sex,
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authService.register(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        passwordConfirmation: passwordConfirmation,
        phoneNumber: phoneNumber,
        birthdayDate: birthdayDate,
        sex: sex,
      );

      if (response.success && response.data != null) {
        _currentUser.value = response.data!.user;
        _isLoggedIn.value = true;
        return true;
      } else {
        _errorMessage.value = response.error ?? 'Erreur lors de l\'inscription';
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Erreur inattendue: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // =========================================================================
  // OTP (VÉRIFICATION)
  // =========================================================================

  /// Demander un code OTP
  Future<OtpRequestResponse?> requestOtp({
    required String email,
    String type = 'verify_user',
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      print('📤 Demande d\'OTP pour $email de type $type');

      final response = await _authService.requestOtp(email: email, type: type);

      if (response.success && response.data != null) {
        print('✅ OTP envoyé avec succès');
        return response.data!;
      } else {
        print('❌ Échec d\'envoi OTP: ${response.error}');
        _errorMessage.value =
            response.error ?? 'Erreur lors de l\'envoi du code';
        return null;
      }
    } catch (e) {
      print('💥 Erreur lors de la demande OTP: $e');
      _errorMessage.value = 'Erreur inattendue: $e';
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Vérifier le code OTP
  Future<bool> verifyOtp({required String email, required String code}) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      print('🔍 Vérification OTP pour $email avec code $code');

      final response = await _authService.verifyOtp(email: email, code: code);

      if (response.success && response.data != null) {
        print('✅ OTP vérifié avec succès');
        // Mettre à jour l'utilisateur avec les nouvelles données (is_verified = true)
        _currentUser.value = response.data!.user;
        // S'assurer que l'état de connexion est mis à jour
        _isLoggedIn.value = true;
        print('👤 Utilisateur mis à jour: ${_currentUser.value?.email}');
        print('🔐 État de connexion: $_isLoggedIn.value');
        return true;
      } else {
        print('❌ Échec de vérification OTP: ${response.error}');
        _errorMessage.value = response.error ?? 'Code de vérification invalide';
        return false;
      }
    } catch (e) {
      print('💥 Erreur lors de la vérification OTP: $e');
      _errorMessage.value = 'Erreur inattendue: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // =========================================================================
  // CONNEXION
  // =========================================================================

  /// Connexion utilisateur
  Future<bool> login({required String email, required String password}) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        _currentUser.value = response.data!;
        _isLoggedIn.value = true;
        return true;
      } else {
        _errorMessage.value =
            response.error ?? 'Email ou mot de passe incorrect';
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Erreur inattendue: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // =========================================================================
  // PROFIL UTILISATEUR
  // =========================================================================

  /// Récupérer les données utilisateur depuis l'API
  Future<void> refreshUserData() async {
    try {
      _isLoading.value = true;

      final response = await _authService.getCurrentUser();

      if (response.success && response.data != null) {
        _currentUser.value = response.data!;
        // S'assurer que l'état de connexion est cohérent
        _isLoggedIn.value = true;
      }
    } catch (e) {
      print('Erreur lors du rafraîchissement des données utilisateur: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  /// Forcer la mise à jour du statut de vérification
  void updateVerificationStatus() {
    final user = _authService.getCurrentUserFromStorage();
    if (user != null) {
      _currentUser.value = user;
      _isLoggedIn.value = true;
    }
  }

  /// Effacer les erreurs précédentes (utile pour recommencer un processus)
  void clearAllErrors() {
    _errorMessage.value = '';
  }

  /// Préparer une nouvelle session d'inscription
  void prepareNewRegistration() {
    clearAllErrors();
    // Effacer les données utilisateur précédentes si elles existent
    _currentUser.value = null;
    _isLoggedIn.value = false;
    print('🧹 Session d\'inscription préparée');
  }

  /// Mettre à jour le profil utilisateur
  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? birthdayDate,
    String? sex,
    String? picture,
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final response = await _authService.updateCurrentUser(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        birthdayDate: birthdayDate,
        sex: sex,
        picture: picture,
      );

      if (response.success && response.data != null) {
        _currentUser.value = response.data!;
        return true;
      } else {
        _errorMessage.value = response.error ?? 'Erreur lors de la mise à jour';
        return false;
      }
    } catch (e) {
      _errorMessage.value = 'Erreur inattendue: $e';
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // =========================================================================
  // DÉCONNEXION
  // =========================================================================

  /// Déconnexion utilisateur
  Future<void> logout() async {
    try {
      _isLoading.value = true;

      await _authService.logout();

      // Nettoyer l'état
      _currentUser.value = null;
      _isLoggedIn.value = false;
      _errorMessage.value = '';

      // Rediriger vers la page de connexion
      Get.offAllNamed('/onboarding');
    } finally {
      _isLoading.value = false;
    }
  }

  // =========================================================================
  // UTILITAIRES
  // =========================================================================

  /// Vérifier si un email est déjà utilisé (utilitaire pour la validation)
  bool isEmailValid(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  /// Vérifier si un mot de passe est valide
  bool isPasswordValid(String password) {
    return password.length >= 8;
  }

  /// Formater la date pour l'API (YYYY-MM-DD)
  String formatDateForApi(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Parser une date depuis le format API
  DateTime? parseDateFromApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.tryParse(dateString);
  }

  // =========================================================================
  // GESTION D'ERREURS SPÉCIFIQUES
  // =========================================================================

  /// Afficher un message de succès
  void showSuccessMessage(String message) {
    Get.snackbar(
      'Succès',
      message,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  /// Afficher un message d'erreur
  void showErrorMessage(String message) {
    Get.snackbar(
      'Erreur',
      message,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }
}
