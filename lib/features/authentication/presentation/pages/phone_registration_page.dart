import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
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
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.roboto,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 50),

              // Champ téléphone avec CustomTextField
              CustomTextField(
                hintText: 'Votre numéro',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefix: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        _selectedCountry == 'FR'
                            ? AppAssets.france
                            : AppAssets.togo,
                        width: 24,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      DropdownButton<String>(
                        value: _selectedCountry,
                        underline: Container(),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                        items: const [
                          DropdownMenuItem(value: 'FR', child: Text('+33')),
                          DropdownMenuItem(value: 'TG', child: Text('+228')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro';
                  }
                  return null;
                },
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
