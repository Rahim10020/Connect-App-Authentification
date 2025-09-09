import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6, // OTP à 6 chiffres selon la doc API
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  String? email;
  String? otpId;
  DateTime? expiresAt;
  bool? fromRegistration;

  Timer? _timer;
  int _countdown = 0;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Récupérer les données depuis la page précédente
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      email = arguments['email'];
      otpId = arguments['otpId'];
      expiresAt = arguments['expiresAt'];
      fromRegistration = arguments['fromRegistration'] ?? false;
    }

    // Démarrer le compte à rebours
    _startCountdown();
  }

  void _startCountdown() {
    if (expiresAt != null) {
      final now = DateTime.now();
      final difference = expiresAt!.difference(now);

      if (difference.inSeconds > 0) {
        _countdown = difference.inSeconds;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() {
              _countdown--;
              if (_countdown <= 0) {
                timer.cancel();
              }
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: List.generate(6, (index) {
            final isActive = index < 4; // 4 étapes complétées
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index < 5 ? 4 : 0),
                decoration: BoxDecoration(
                  color: isActive ? AppGreen.green500 : AppGrey.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Titre
            Text(
              'Vérification de votre\nemail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.kanit,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 20),

            // Description avec email
            RichText(
              text: TextSpan(
                text: 'Entrez le code de vérification envoyé à ',
                style: TextStyle(
                  color: AppGrey.grey700,
                  fontSize: 16,
                  fontFamily: AppFonts.kanit,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: email ?? 'votre email',
                    style: TextStyle(
                      color: AppGreen.green500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Champs code OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 48,
                  height: 56,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.roboto,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: AppGrey.grey300,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppGrey.grey400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppGrey.grey400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppGreen.green500,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppRed.red500, width: 2),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                      _checkCompletion();
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // Compte à rebours
            if (_countdown > 0)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppGreen.green50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Code expire dans ${_formatTime(_countdown)}',
                    style: TextStyle(
                      color: AppGreen.green600,
                      fontSize: 14,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Affichage des erreurs
            Obx(() {
              if (authController.errorMessage.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppRed.red50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppRed.red300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppRed.red500, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          authController.errorMessage,
                          style: TextStyle(
                            color: AppRed.red700,
                            fontSize: 14,
                            fontFamily: AppFonts.roboto,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: AppRed.red500, size: 16),
                        onPressed: authController.clearError,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 40),

            // Boutons d'action
            Center(
              child: Column(
                children: [
                  // Bouton Renvoyer le code
                  if (_countdown <= 0)
                    Obx(
                      () => GestureDetector(
                        onTap: authController.isLoading ? null : _resendCode,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppGreen.green500),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              authController.isLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppGreen.green500,
                                      ),
                                    ),
                                  )
                                  : Text(
                                    'Renvoyer le code',
                                    style: TextStyle(
                                      color: AppGreen.green500,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.roboto,
                                    ),
                                  ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Bouton Changer d'email
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Changer d\'email',
                      style: TextStyle(
                        color: AppGrey.grey600,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.roboto,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _checkCompletion() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      // Code complet, procéder à la vérification
      _verifyCode(code);
    }
  }

  void _verifyCode(String code) async {
    if (email == null) return;

    final success = await authController.verifyOtp(email: email!, code: code);

    if (success) {
      print('🎉 Vérification réussie, navigation vers la page d\'accueil');
      authController.showSuccessMessage('Email vérifié avec succès !');

      // Attendre un peu pour s'assurer que les données sont mises à jour
      await Future.delayed(const Duration(milliseconds: 300));

      // Déterminer la navigation suivante
      try {
        print('🏠 Navigation vers /home');
        if (fromRegistration == true) {
          // Si on vient de l'inscription, aller directement à l'accueil
          // (la photo de profil peut être configurée plus tard)
          Get.offAllNamed('/home');
        } else {
          // Sinon, aller à l'accueil
          Get.offAllNamed('/home');
        }
        print('✅ Navigation réussie');
      } catch (e) {
        print('❌ Erreur de navigation: $e');
        // En cas d'erreur de navigation, forcer le rafraîchissement de l'état
        authController.refreshUserData();
        Get.offAllNamed('/home');
      }
    } else {
      // Vérifier si c'est une erreur d'expiration OTP
      final errorMessage = authController.errorMessage.toLowerCase();
      if (errorMessage.contains('expir') || errorMessage.contains('invalid')) {
        print('⏰ OTP expiré ou invalide, suggestion de renvoi');
        // L'erreur s'affiche automatiquement via Obx()
        // Le bouton "Renvoyer le code" sera automatiquement activé
      }
    }
  }

  void _resendCode() async {
    if (email == null) return;

    print('🔄 Renvoi du code OTP pour $email');

    // Effacer tous les champs
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    // Demander un nouveau code
    final otpResponse = await authController.requestOtp(email: email!);

    if (otpResponse != null) {
      print('✅ Nouveau code OTP envoyé');
      // Mettre à jour les données
      setState(() {
        expiresAt = otpResponse.expiresAt;
      });

      // Redémarrer le compte à rebours
      _timer?.cancel();
      _startCountdown();

      authController.showSuccessMessage('Nouveau code envoyé !');
    } else {
      print('❌ Échec du renvoi du code OTP');
      // En cas d'erreur, le message s'affiche automatiquement via Obx()
      // Afficher un message d'aide supplémentaire
      authController.showErrorMessage(
        'Impossible d\'envoyer un nouveau code. Veuillez réessayer dans quelques minutes.'
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
