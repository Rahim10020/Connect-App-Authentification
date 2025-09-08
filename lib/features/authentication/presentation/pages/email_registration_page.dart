import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/controllers/auth_controller.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
import 'package:connect_app/core/widgets/flag_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailRegistrationPage extends StatefulWidget {
  const EmailRegistrationPage({super.key});

  @override
  State<EmailRegistrationPage> createState() => _EmailRegistrationPageState();
}

class _EmailRegistrationPageState extends State<EmailRegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedCountry = 'FR';
  String? selectedProfile;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Récupérer le profil sélectionné depuis la page précédente
    selectedProfile = Get.arguments as String?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            // Indicateur de progression - 2ème étape
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGreen.green500,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGreen.green500,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGrey.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGrey.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGrey.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGrey.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Titre
                Text(
                  'Créer votre compte',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.kanit,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 30),

                // Champ email
                CustomTextField(
                  labelText: 'Email *',
                  hintText: 'votre.email@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'L\'email est obligatoire';
                    }
                    if (!authController.isEmailValid(value)) {
                      return 'Veuillez saisir un email valide';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Champ téléphone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Téléphone (optionnel)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.kanit,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FlagTextField(
                      onChanged:
                          (value) => setState(() {
                            _selectedCountry = value!;
                          }),
                      controller: _phoneController,
                      selectedCountry: _selectedCountry,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Champ mot de passe
                CustomTextField(
                  labelText: 'Mot de passe *',
                  hintText: 'Votre mot de passe',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le mot de passe est obligatoire';
                    }
                    if (!authController.isPasswordValid(value)) {
                      return 'Le mot de passe doit contenir au moins 8 caractères';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Confirmation mot de passe
                CustomTextField(
                  labelText: 'Confirmer le mot de passe *',
                  hintText: 'Confirmez votre mot de passe',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre mot de passe';
                    }
                    if (value != _passwordController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
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

                const SizedBox(height: 20),

                // Bouton d'inscription
                Obx(
                  () => CustomButton(
                    text: 'Créer le compte',
                    onPressed: _handleNext,
                    isLoading: authController.isLoading,
                  ),
                ),

                const SizedBox(height: 20),

                // Termes et conditions
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'En créant un compte, vous acceptez nos ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.kanit,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: 'Conditions d\'utilisation',
                        style: TextStyle(
                          color: AppGreen.green600,
                          fontSize: 12,
                          fontFamily: AppFonts.kanit,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' et notre ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.kanit,
                        ),
                      ),
                      TextSpan(
                        text: 'Politique de confidentialité',
                        style: TextStyle(
                          color: AppGreen.green600,
                          fontSize: 12,
                          fontFamily: AppFonts.kanit,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNext() async {
    // Effacer les erreurs précédentes
    authController.clearError();

    if (_formKey.currentState!.validate()) {
      // Préparer les données d'inscription
      final registrationData = {
        'profile': selectedProfile,
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'countryCode': _selectedCountry,
        'password': _passwordController.text,
        'passwordConfirmation': _confirmPasswordController.text,
      };

      // Naviguer vers la page d'informations supplémentaires
      // On va d'abord collecter toutes les infos, puis faire l'inscription
      Get.toNamed('/additional-info', arguments: registrationData);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
