import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? phoneNumber;
  String? countryCode;
  String? selectedProfile;
  String? verificationCode;

  @override
  void initState() {
    super.initState();
    // Récupérer les données depuis la page précédente
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      selectedProfile = arguments['profile'];
      phoneNumber = arguments['phone'];
      countryCode = arguments['countryCode'];
      verificationCode = arguments['verificationCode'];
    }
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
            // Indicateur de progression - 4ème étape
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
                const SizedBox(height: 40),

                // Titre
                Text(
                  'Créez votre mot de passe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.kanit,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 50),

                // Champ mot de passe
                CustomTextField(
                  labelText: 'Mot de passe',
                  hintText: 'Votre mot de passe',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Champ confirmation mot de passe
                CustomTextField(
                  labelText: 'Confirmer',
                  hintText: 'Votre mot de passe',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Bouton Continuer
                CustomButton(text: 'Continuer', onPressed: _handleContinue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Naviguer vers la page suivante avec toutes les données
      Get.toNamed(
        '/additional-info',
        arguments: {
          'profile': selectedProfile,
          'phone': phoneNumber,
          'countryCode': countryCode,
          'verificationCode': verificationCode,
          'password': _passwordController.text,
        },
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
