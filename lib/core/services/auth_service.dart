// lib/core/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../models/auth_models.dart';

class AuthService {
  static const String _baseUrl = 'https://skillmap-backend-7r5s.onrender.com';
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  final GetStorage _storage = GetStorage();

  // Headers par défaut
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Headers avec token d'authentification
  Map<String, String> get _authHeaders {
    final token = getToken();
    return {..._headers, if (token != null) 'Authorization': 'Bearer $token'};
  }

  // =========================================================================
  // INSCRIPTION
  // =========================================================================

  /// Inscription d'un nouvel utilisateur
  Future<ApiResponse<RegisterResponse>> register({
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
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: _headers,
        body: json.encode({
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'password_confirmation': passwordConfirmation,
          if (phoneNumber != null) 'phone_number': phoneNumber,
          if (birthdayDate != null) 'birthday_date': birthdayDate,
          if (sex != null) 'sex': sex,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        final registerResponse = RegisterResponse.fromJson(data);

        // Sauvegarder le token et l'utilisateur
        await _saveAuthData(
          registerResponse.accessToken.token,
          registerResponse.user,
        );

        return ApiResponse.success(registerResponse);
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  // =========================================================================
  // OTP (VÉRIFICATION)
  // =========================================================================

  /// Demander un code OTP par email
  Future<ApiResponse<OtpRequestResponse>> requestOtp({
    required String email,
    String type = 'verify_user',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/otp/request'),
        headers: _headers,
        body: json.encode({'email': email, 'type': type}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(OtpRequestResponse.fromJson(data));
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  /// Vérifier le code OTP
  Future<ApiResponse<OtpVerifyResponse>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/otp/verify'),
        headers: _headers,
        body: json.encode({'email': email, 'code': code}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final otpResponse = OtpVerifyResponse.fromJson(data);

        // L'utilisateur est maintenant vérifié, on peut mettre à jour les données
        await _storage.write(_userKey, otpResponse.user.toJson());

        return ApiResponse.success(otpResponse);
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  // =========================================================================
  // CONNEXION
  // =========================================================================

  /// Connexion utilisateur
  Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: _headers,
        body: json.encode({'email': email, 'password': password}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        final user = User.fromJson(data['user']);

        // Récupérer le token (si fourni dans la réponse de login)
        // Note: Selon la doc, login ne retourne que l'user, pas le token

        await _storage.write(_userKey, user.toJson());

        return ApiResponse.success(user);
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  // =========================================================================
  // PROFIL UTILISATEUR
  // =========================================================================

  /// Récupérer le profil utilisateur actuel
  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/me'),
        headers: _authHeaders,
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(data);
        await _storage.write(_userKey, user.toJson());
        return ApiResponse.success(user);
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  /// Mettre à jour le profil utilisateur
  Future<ApiResponse<User>> updateCurrentUser({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? birthdayDate,
    String? sex,
    String? picture,
  }) async {
    try {
      final body = <String, dynamic>{};

      if (firstName != null) body['first_name'] = firstName;
      if (lastName != null) body['last_name'] = lastName;
      if (phoneNumber != null) body['phone_number'] = phoneNumber;
      if (birthdayDate != null) body['birthday_date'] = birthdayDate;
      if (sex != null) body['sex'] = sex;
      if (picture != null) body['picture'] = picture;

      final response = await http.put(
        Uri.parse('$_baseUrl/current/update'),
        headers: _authHeaders,
        body: json.encode(body),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(data);
        await _storage.write(_userKey, user.toJson());
        return ApiResponse.success(user);
      } else {
        return ApiResponse.error(
          _extractErrorMessage(data),
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Erreur de connexion: $e');
    }
  }

  // =========================================================================
  // DÉCONNEXION
  // =========================================================================

  /// Déconnexion utilisateur
  Future<ApiResponse<void>> logout() async {
    try {
      await http.delete(Uri.parse('$_baseUrl/logout'), headers: _authHeaders);

      // Nettoyer les données locales même si la requête échoue
      await _clearAuthData();

      return ApiResponse.success(null);
    } catch (e) {
      // Nettoyer les données locales même en cas d'erreur
      await _clearAuthData();
      return ApiResponse.error('Erreur lors de la déconnexion: $e');
    }
  }

  // =========================================================================
  // GESTION DES TOKENS ET DONNÉES LOCALES
  // =========================================================================

  /// Sauvegarder les données d'authentification
  Future<void> _saveAuthData(String token, User user) async {
    await _storage.write(_tokenKey, token);
    await _storage.write(_userKey, user.toJson());
  }

  /// Nettoyer les données d'authentification
  Future<void> _clearAuthData() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
  }

  /// Récupérer le token stocké
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  /// Récupérer l'utilisateur stocké
  User? getCurrentUserFromStorage() {
    final userData = _storage.read(_userKey);
    if (userData != null) {
      return User.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  /// Vérifier si l'utilisateur est connecté
  bool get isLoggedIn => getToken() != null;

  /// Vérifier si l'utilisateur est vérifié
  bool get isUserVerified {
    final user = getCurrentUserFromStorage();
    return user?.isVerified ?? false;
  }

  // =========================================================================
  // UTILITAIRES
  // =========================================================================

  /// Extraire le message d'erreur de la réponse API
  String _extractErrorMessage(Map<String, dynamic> data) {
    // Gestion des erreurs de validation (422)
    if (data.containsKey('detail') && data['detail'] is List) {
      final details = data['detail'] as List;
      if (details.isNotEmpty) {
        return details.first['msg'] ?? 'Erreur de validation';
      }
    }

    // Autres messages d'erreur
    if (data.containsKey('detail') && data['detail'] is String) {
      return data['detail'];
    }

    if (data.containsKey('message')) {
      return data['message'];
    }

    return 'Une erreur est survenue';
  }
}
