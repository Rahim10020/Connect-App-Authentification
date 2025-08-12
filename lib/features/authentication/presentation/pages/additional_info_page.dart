import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalInfoPage extends StatefulWidget {
  const AdditionalInfoPage({super.key});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedGender = '';
  bool _obscureBirthDate = true;

  String? phoneNumber;
  String? countryCode;
  String? selectedProfile;
  String? verificationCode;
  String? password;

  final List<String> genderOptions = ['Homme', 'Femme', 'Autre'];

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
      password = arguments['password'];
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
            // Indicateur de progression - 5ème étape (toutes les étapes)
            ...List.generate(
              5,
              (index) => [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppGreen.green500,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 4) const SizedBox(width: 4),
              ],
            ).expand((x) => x),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Text(
                'Information\nsupplémentaires',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.kanit,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 27),

              // Champ Nom
              CustomTextField(
                labelText: 'Nom',
                hintText: 'Votre adresse de résidence',
                controller: _lastNameController,
                validator: (value) {
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Champ Prénom
              CustomTextField(
                labelText: 'Prénom',
                hintText: 'Votre adresse de résidence',
                controller: _firstNameController,
                validator: (value) {
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Champ Genre (Dropdown)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Genre',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppGrey.grey300,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppGrey.grey400),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender.isEmpty ? null : _selectedGender,
                      decoration: InputDecoration(
                        hintText: 'Votre genre',
                        hintStyle: TextStyle(
                          color: AppGrey.grey600,
                          fontSize: 16,
                          fontFamily: AppFonts.roboto,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items:
                          genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppFonts.roboto,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Champ Date de naissance
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date de naissance',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppGrey.grey300,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppGrey.grey400),
                    ),
                    child: TextFormField(
                      controller: _birthDateController,
                      obscureText: _obscureBirthDate,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.roboto,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '--/--/--',
                        hintStyle: TextStyle(
                          color: AppGrey.grey600,
                          fontSize: 16,
                          fontFamily: AppFonts.roboto,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureBirthDate
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppGrey.grey600,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureBirthDate = !_obscureBirthDate;
                            });
                          },
                        ),
                      ),
                      onTap: () async {
                        // Ouvrir le sélecteur de date
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _birthDateController.text =
                              '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                        }
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Champ Adresse de résidence
              CustomTextField(
                labelText: 'Adresse de résidence',
                hintText: 'Votre adresse de résidence',
                controller: _addressController,
                validator: (value) {
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // Bouton Continuer
              CustomButton(text: 'Continuer', onPressed: _handleContinue),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // Naviguer vers la page de photo de profil
      Get.toNamed('/profile-photo');
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
