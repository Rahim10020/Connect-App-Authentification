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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Header avec logo Connect
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppGreen.green500),
                  borderRadius: BorderRadius.circular(AppSizes.radiusBig),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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

              const SizedBox(height: 60),

              // Illustration des personnes
              Container(
                width: 197.36,
                height: 149,
                child: Image.asset(
                  AppAssets.greetingImage,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 50),

              // Titre principal
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Explorez un monde",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "d'apprentissage",
                    style: TextStyle(
                      color: AppGreen.green500,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "enrichissant",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.roboto,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      height: 1.2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                'Prêt à transformer votre façon\nd\'apprendre et d\'enseigner ? Téléchargez\nmaintenant notre application éducative !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppGrey.grey700,
                  fontSize: 16,
                  fontFamily: AppFonts.roboto,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // Boutons
              Column(
                children: [
                  CustomButton(
                    text: 'Connexion',
                    onPressed: () => Get.offNamed('/login'),
                  ),

                  const SizedBox(height: 16),

                  CustomButton(
                    text: 'Inscription',
                    onPressed: () => Get.toNamed('/profile-selection'),
                    isOutlined: true,
                  ),

                  const SizedBox(height: 24),

                  // Conditions d'utilisation
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'En cliquant sur "Connexion", vous acceptez les termes et ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.kanit,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'Conditions\ngénérale d\'utilisation',
                          style: TextStyle(
                            color: AppGreen.green600,
                            fontSize: 12,
                            fontFamily: AppFonts.kanit,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '. Pour plus d\'infos, consultez notre ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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

                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
