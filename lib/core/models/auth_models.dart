// lib/core/models/auth_models.dart

// =========================================================================
// RÉPONSE GÉNÉRIQUE D'API
// =========================================================================

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResponse._({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(success: true, data: data);
  }

  factory ApiResponse.error(String error, [int? statusCode]) {
    return ApiResponse._(success: false, error: error, statusCode: statusCode);
  }
}

// =========================================================================
// MODÈLES UTILISATEUR
// =========================================================================

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? birthdayDate;
  final String? sex;
  final String? picture;
  final bool isActive;
  final bool isVerified;
  final String? locale;
  final DateTime createdAt;
  final List<String> permissions;
  final List<String> roles;
  final String? socialLoginId;
  final String? socialLoginProvider;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.birthdayDate,
    this.sex,
    this.picture,
    required this.isActive,
    required this.isVerified,
    this.locale,
    required this.createdAt,
    required this.permissions,
    required this.roles,
    this.socialLoginId,
    this.socialLoginProvider,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'],
      birthdayDate: json['birthday_date'],
      sex: json['sex'],
      picture: json['picture'],
      isActive: json['is_active'] ?? false,
      isVerified: json['is_verified'] ?? false,
      locale: json['locale'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      permissions: List<String>.from(json['permissions'] ?? []),
      roles: List<String>.from(json['roles'] ?? []),
      socialLoginId: json['social_login__id'] ?? json['social_login_id'],
      socialLoginProvider: json['social_login_provider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'birthday_date': birthdayDate,
      'sex': sex,
      'picture': picture,
      'is_active': isActive,
      'is_verified': isVerified,
      'locale': locale,
      'created_at': createdAt.toIso8601String(),
      'permissions': permissions,
      'roles': roles,
      'social_login_id': socialLoginId,
      'social_login_provider': socialLoginProvider,
    };
  }

  // Getters utiles
  String get fullName => '$firstName $lastName';
  bool get hasProfilePicture => picture != null && picture!.isNotEmpty;

  // Copier avec modifications
  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? birthdayDate,
    String? sex,
    String? picture,
    bool? isActive,
    bool? isVerified,
    String? locale,
    DateTime? createdAt,
    List<String>? permissions,
    List<String>? roles,
    String? socialLoginId,
    String? socialLoginProvider,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthdayDate: birthdayDate ?? this.birthdayDate,
      sex: sex ?? this.sex,
      picture: picture ?? this.picture,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
      socialLoginId: socialLoginId ?? this.socialLoginId,
      socialLoginProvider: socialLoginProvider ?? this.socialLoginProvider,
    );
  }
}

// =========================================================================
// MODÈLES D'AUTHENTIFICATION
// =========================================================================

class AccessToken {
  final String id;
  final String token;
  final String userId;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool revoked;

  AccessToken({
    required this.id,
    required this.token,
    required this.userId,
    required this.createdAt,
    required this.expiresAt,
    required this.revoked,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      id: json['id'] ?? '',
      token: json['token'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      expiresAt: DateTime.tryParse(json['expires_at'] ?? '') ?? DateTime.now(),
      revoked: json['revoked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt.toIso8601String(),
      'revoked': revoked,
    };
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid => !revoked && !isExpired;
}

class RegisterResponse {
  final User user;
  final AccessToken accessToken;

  RegisterResponse({required this.user, required this.accessToken});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      user: User.fromJson(json['user']),
      accessToken: AccessToken.fromJson(json['access_token']),
    );
  }
}

// =========================================================================
// MODÈLES OTP
// =========================================================================

class OtpRequestResponse {
  final String code;
  final String email;
  final String otpId;
  final String type;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isUsed;
  final String detail;

  OtpRequestResponse({
    required this.code,
    required this.email,
    required this.otpId,
    required this.type,
    required this.createdAt,
    required this.expiresAt,
    required this.isUsed,
    required this.detail,
  });

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) {
    return OtpRequestResponse(
      code: json['code'] ?? '',
      email: json['email'] ?? '',
      otpId: json['otp_id'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      expiresAt: DateTime.tryParse(json['expires_at'] ?? '') ?? DateTime.now(),
      isUsed: json['is_used'] ?? false,
      detail: json['detail'] ?? '',
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  Duration get timeRemaining => expiresAt.difference(DateTime.now());
}

class Otp {
  final String code;
  final String email;
  final String otpId;
  final String type;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isUsed;
  final String detail;

  Otp({
    required this.code,
    required this.email,
    required this.otpId,
    required this.type,
    required this.createdAt,
    required this.expiresAt,
    required this.isUsed,
    required this.detail,
  });

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      code: json['code'] ?? '',
      email: json['email'] ?? '',
      otpId: json['otp_id'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      expiresAt: DateTime.tryParse(json['expires_at'] ?? '') ?? DateTime.now(),
      isUsed: json['is_used'] ?? false,
      detail: json['detail'] ?? '',
    );
  }
}

class OtpVerifyResponse {
  final String detail;
  final Otp otp;
  final User user;

  OtpVerifyResponse({
    required this.detail,
    required this.otp,
    required this.user,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      detail: json['detail'] ?? '',
      otp: Otp.fromJson(json['otp']),
      user: User.fromJson(json['user']),
    );
  }
}

// =========================================================================
// ENUMS ET CONSTANTES
// =========================================================================

enum Gender {
  male('M'),
  female('F');

  const Gender(this.value);
  final String value;

  static Gender? fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'M':
      case 'MALE':
        return Gender.male;
      case 'F':
      case 'FEMALE':
        return Gender.female;
      default:
        return null;
    }
  }
}

enum UserRole {
  user('user'),
  admin('admin'),
  teacher('teacher'),
  student('student');

  const UserRole(this.value);
  final String value;

  static UserRole? fromString(String? value) {
    for (var role in UserRole.values) {
      if (role.value == value) return role;
    }
    return null;
  }
}

enum OtpType {
  verifyUser('verify_user'),
  resetPassword('reset_password');

  const OtpType(this.value);
  final String value;
}
