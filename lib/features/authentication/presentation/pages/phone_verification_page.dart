import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  String? phoneNumber;
  String? countryCode;
  String? selectedProfile;

  @override
  void initState() {
    super.initState();
    // Récupérer les données depuis la page précédente
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      selectedProfile = arguments['profile'];
      phoneNumber = arguments['phone'];
      countryCode = arguments['countryCode'];
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
            final isActive = index < 3; // 3 étapes complétées
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
              'Vérification du numéro de\ntéléphone',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.kanit,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 20),

            // Description avec numéro
            Text(
              'Entrer le code de vérification envoyé au ${_getFormattedPhone()}',
              style: TextStyle(
                color: AppGrey.grey700,
                fontSize: 16,
                fontFamily: AppFonts.kanit,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 40),

            // Champs code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 56,
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
                      contentPadding: EdgeInsets.zero,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 4) {
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

            const SizedBox(height: 60),

            // Boutons d'action
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      'Renvoyer',
                      style: TextStyle(
                        color: AppGreen.green500,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.kanit,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Changer de mail',
                      style: TextStyle(
                        color: AppGreen.green500,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.kanit,
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

  String _getFormattedPhone() {
    if (phoneNumber == null) return '+228 93 24 05 84';

    String code = countryCode == 'FR' ? '+33' : '+228';
    return '$code $phoneNumber';
  }

  void _checkCompletion() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length == 5) {
      // Code complet, procéder à la vérification
      _verifyCode(code);
    }
  }

  void _verifyCode(String code) async {
    // Simuler la vérification
    await Future.delayed(const Duration(seconds: 1));

    // Naviguer vers la page suivante
    Get.toNamed(
      '/create-password',
      arguments: {
        'profile': selectedProfile,
        'phone': phoneNumber,
        'countryCode': countryCode,
        'verificationCode': code,
      },
    );
  }

  void _resendCode() {
    // Effacer tous les champs
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    // Afficher message de confirmation
    Get.snackbar(
      'Code renvoyé',
      'Un nouveau code a été envoyé à votre numéro',
      backgroundColor: AppGreen.green500,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
