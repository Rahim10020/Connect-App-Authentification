import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/controllers/auth_controller.dart';
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
  DateTime? _selectedDate;

  // Données depuis les pages précédentes
  Map<String, dynamic>? registrationData;

  final List<String> genderOptions = ['Homme', 'Femme', 'Autre'];
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Récupérer les données depuis les pages précédentes
    registrationData = Get.arguments as Map<String, dynamic>?;
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
            // Indicateur de progression - 3ème étape
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
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre
              Text(
                'Informations\nsupplémentaires',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.kanit,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 27),

              // Champ Nom
              CustomTextField(
                labelText: 'Nom *',
                hintText: 'Votre nom de famille',
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le nom est obligatoire';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Champ Prénom
              CustomTextField(
                labelText: 'Prénom *',
                hintText: 'Votre prénom',
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le prénom est obligatoire';
                  }
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
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppGrey.grey400),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender.isEmpty ? null : _selectedGender,
                      decoration: InputDecoration(
                        hintText: 'Sélectionnez votre genre',
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
                        // Genre optionnel
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
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppGrey.grey400),
                    ),
                    child: TextFormField(
                      controller: _birthDateController,
                      readOnly: true, // Empêcher la saisie directe
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.roboto,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '--/--/----',
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
                            Icons.calendar_today,
                            color: AppGrey.grey800,
                            size: 20,
                          ),
                          onPressed: _selectDate,
                        ),
                      ),
                      onTap: _selectDate,
                      validator: (value) {
                        // Date de naissance optionnelle
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
                  // Adresse optionnelle
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

              // Bouton Continuer
              Obx(
                () => CustomButton(
                  text: 'Créer le compte',
                  onPressed: _handleContinue,
                  isLoading: authController.isLoading,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now().subtract(
            const Duration(days: 6570),
          ), // 18 ans par défaut
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppGreen.green500,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  void _handleContinue() async {
    // Effacer les erreurs précédentes
    authController.clearError();

    if (_formKey.currentState!.validate()) {
      // Préparer les données complètes pour l'inscription
      final email = registrationData?['email'] ?? '';
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final password = registrationData?['password'] ?? '';
      final passwordConfirmation =
          registrationData?['passwordConfirmation'] ?? '';
      final phoneNumber =
          registrationData?['phone']?.isNotEmpty == true
              ? registrationData!['phone']
              : null;

      // Convertir le genre en format API
      String? sexForApi;
      switch (_selectedGender) {
        case 'Homme':
          sexForApi = 'M';
          break;
        case 'Femme':
          sexForApi = 'F';
          break;
        default:
          sexForApi = null;
      }

      // Convertir la date en format API (YYYY-MM-DD)
      String? birthdayDateForApi;
      if (_selectedDate != null) {
        birthdayDateForApi = authController.formatDateForApi(_selectedDate!);
      }

      // Effectuer l'inscription
      final success = await authController.register(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        passwordConfirmation: passwordConfirmation,
        phoneNumber: phoneNumber,
        birthdayDate: birthdayDateForApi,
        sex: sexForApi,
      );

      if (success) {
        authController.showSuccessMessage('Compte créé avec succès !');

        // Attendre un peu pour s'assurer que les données sont sauvegardées
        await Future.delayed(const Duration(milliseconds: 500));

        // Demander l'OTP pour vérifier l'email
        final otpResponse = await authController.requestOtp(email: email);

        if (otpResponse != null) {
          // Naviguer vers la page de vérification OTP
          Get.toNamed(
            '/verification',
            arguments: {
              'email': email,
              'otpId': otpResponse.otpId,
              'expiresAt': otpResponse.expiresAt,
              'fromRegistration': true,
            },
          );
        } else {
          // En cas d'erreur OTP, afficher un message d'erreur
          authController.showErrorMessage(
            'Erreur lors de l\'envoi du code de vérification. '
            'Si vous avez déjà essayé de vous inscrire avec cet email, '
            'veuillez attendre quelques minutes avant de réessayer.'
          );
        }
      }
      // En cas d'erreur d'inscription, le message s'affiche automatiquement via Obx()
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
