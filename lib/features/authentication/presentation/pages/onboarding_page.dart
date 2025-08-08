import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/constants/app_sizes.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header avec logo
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppGreen.green500),
                  borderRadius: BorderRadius.circular(AppSizes.radiusBig),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Connect',
                  style: TextStyle(
                    color: AppGreen.green700,
                    fontSize: 14,
                    fontFamily: AppFonts.kanit,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Illustration
              Container(
                width: 197.36,
                height: 149.00,
                child: Image.asset(
                  AppAssets.greetingImage,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 39),

              // Titre et description
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Explorez un Monde",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "d'apprentissage",
                    style: TextStyle(
                      color: AppGreen.green500,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    "enrichissant",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 14),
                  Text(
                    'Prêt à transformer votre façon\nd\'apprendre et d\'enseigner ? Téléchargez\nmaintenant notre application éducative !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppGrey.grey700,
                      fontSize: 18,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // Boutons
              Column(
                children: [
                  CustomButton(
                    text: 'Connection',
                    onPressed: () => Get.offNamed('/login'),
                  ),

                  const SizedBox(height: 16),

                  CustomButton(
                    text: 'Inscription',
                    onPressed: () {
                      // Navigation vers page d'inscription
                    },
                    isOutlined: true,
                  ),

                  const SizedBox(height: 20),

                  // Conditions d'utilisation
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'En cliquant sur "Connexion", vous acceptez les termes et ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.kanit,
                      ),
                      children: [
                        TextSpan(
                          text: 'Conditions\ngénérale d\'utilisation',
                          style: TextStyle(
                            color: AppGreen.green600,
                            fontSize: 11,
                            fontFamily: AppFonts.kanit,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '. Pour plus d\'infos, consultez notre ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFonts.kanit,
                          ),
                        ),
                        TextSpan(
                          text: 'Politique de\nconfidentialité',
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
            ],
          ),
        ),
      ),
    );
  }
}
