import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/controllers/auth_controller.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
import 'package:connect_app/core/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Récupérer le contrôleur d'authentification
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Logo
                const LogoWidget(size: 60),

                const SizedBox(height: 4),

                // Titre
                Text(
                  'Connexion',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.kanit,
                  ),
                ),

                const SizedBox(height: 61),

                // Champ email
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'votre.email@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre email';
                    }
                    if (!authController.isEmailValid(value)) {
                      return 'Veuillez saisir un email valide';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Champ mot de passe
                CustomTextField(
                  labelText: 'Mot de passe',
                  hintText: 'Votre mot de passe',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Bouton de connexion avec état de chargement
                Obx(
                  () => CustomButton(
                    text: 'Se connecter',
                    onPressed: _handleLogin,
                    isLoading: authController.isLoading,
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
                          Icon(
                            Icons.error_outline,
                            color: AppRed.red500,
                            size: 20,
                          ),
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
                            icon: Icon(
                              Icons.close,
                              color: AppRed.red500,
                              size: 16,
                            ),
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

                // Mot de passe oublié
                GestureDetector(
                  onTap: () {
                    // laisser pour le moment
                    Get.snackbar(
                      'Info',
                      'Fonctionnalité bientôt disponible',
                      backgroundColor: AppGreen.green500,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      color: AppGreen.green500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Pas de compte
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pas de compte ? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppFonts.roboto,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Effacer les erreurs et naviguer vers l'inscription
                        authController.clearError();
                        Get.toNamed('/profile-selection');
                      },
                      child: Text(
                        'Créer un compte !',
                        style: TextStyle(
                          color: AppGreen.green500,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.roboto,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    // Effacer les erreurs précédentes
    authController.clearError();

    if (_formKey.currentState!.validate()) {
      final success = await authController.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success) {
        // Connexion réussie, GetX se charge de la navigation via AuthMiddleware
        authController.showSuccessMessage('Connexion réussie !');
        Get.offAllNamed('/home');
      }
      // En cas d'erreur, le message s'affiche automatiquement via Obx()
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
