import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/flag_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneRegistrationPage extends StatefulWidget {
  const PhoneRegistrationPage({super.key});

  @override
  State<PhoneRegistrationPage> createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedCountry = 'FR';
  String? selectedProfile;

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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Titre
              Text(
                'Votre Numéro de téléphone',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.kanit,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 50),

              // Champ téléphone avec CustomTextField
              FlagTextField(
                selectedCountry: _selectedCountry,
                onChanged:
                    (value) => setState(() {
                      _selectedCountry = value!;
                    }),
                controller: _phoneController,
              ),
              const SizedBox(height: 40),

              // Bouton S'inscrire
              CustomButton(text: 'S\'inscrire', onPressed: _handleNext),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      // Naviguer vers la page suivante avec les données
      Get.toNamed(
        '/verification',
        arguments: {
          'profile': selectedProfile,
          'phone': _phoneController.text,
          'countryCode': _selectedCountry,
        },
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
