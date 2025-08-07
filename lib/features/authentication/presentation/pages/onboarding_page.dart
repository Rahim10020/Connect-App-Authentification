import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_text_styles.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/logo_widget.dart';
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
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header avec logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const LogoWidget(size: 40),
                  TextButton(
                    onPressed: () => Get.offNamed('/login'),
                    child: Text(
                      'Connect',
                      style: TextStyle(
                        color: AppGreen.green700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Illustration
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    AppAssets.greetingImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Titre et description
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Explorez un monde\n',
                            style: AppTextStyles.heading1,
                          ),
                          TextSpan(
                            text: 'd\'apprentissage\n',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppGreen.green500,
                              fontFamily: 'Kanit',
                            ),
                          ),
                          TextSpan(
                            text: 'enrichissant',
                            style: AppTextStyles.heading1,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Prêt à transformer votre façon\nd\'apprendre et d\'enseigner ? Téléchargez\nmaintenant notre application éducative !',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body1,
                    ),
                  ],
                ),
              ),

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            'En cliquant sur "Connexion", vous acceptez les termes et ',
                        style: AppTextStyles.body2.copyWith(fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Conditions\ngénérale d\'utilisation',
                            style: TextStyle(
                              color: AppGreen.green600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '. Pour plus d\'infos, consultez notre ',
                            style: AppTextStyles.body2.copyWith(fontSize: 12),
                          ),
                          TextSpan(
                            text: 'Politique de\nconfidentialité',
                            style: TextStyle(
                              color: AppGreen.green600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
