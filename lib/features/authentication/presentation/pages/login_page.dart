import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_text_styles.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:connect_app/core/widgets/custom_text_field.dart';
import 'package:connect_app/core/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCountry = 'TG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo et titre
                const LogoWidget(size: 60),

                const SizedBox(height: 24),

                const Text('Connection', style: AppTextStyles.heading1),

                const SizedBox(height: 40),

                // Champ téléphone
                CustomTextField(
                  labelText: 'Téléphone',
                  hintText: 'Votre numéro',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefix: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          _selectedCountry == 'TG'
                              ? AppAssets.togo
                              : AppAssets.france,
                          width: 24,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        DropdownButton<String>(
                          value: _selectedCountry,
                          underline: Container(),
                          items: [
                            DropdownMenuItem(value: 'TG', child: Text('+228')),
                            DropdownMenuItem(value: 'FR', child: Text('+33')),
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

                const SizedBox(height: 20),

                // Champ mot de passe
                CustomTextField(
                  labelText: 'Mot de passe',
                  hintText: 'Votre mot de passe',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Bouton de connexion
                CustomButton(
                  text: 'Se connecter',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simuler une connexion
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Afficher un message de succès
      Get.snackbar(
        'Succès',
        'Connexion réussie !',
        backgroundColor: AppGreen.green600,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
