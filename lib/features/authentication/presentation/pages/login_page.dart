import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
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
  bool _obscurePassword = true;
  String _selectedCountry = 'FR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // Logo
                const LogoWidget(size: 60),

                const SizedBox(height: 32),

                // Titre
                Text(
                  'Connexion',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.roboto,
                  ),
                ),

                const SizedBox(height: 50),

                // Champ téléphone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Téléphone',
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
                      child: Row(
                        children: [
                          // Prefix avec drapeau et code pays
                          Container(
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
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'FR',
                                      child: Text('+33'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'TG',
                                      child: Text('+228'),
                                    ),
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
                          Container(
                            width: 1,
                            height: 24,
                            color: AppGrey.grey400,
                          ),
                          // Champ de saisie
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.roboto,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Votre numéro',
                                hintStyle: TextStyle(
                                  color: AppGrey.grey600,
                                  fontSize: 16,
                                  fontFamily: AppFonts.roboto,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre numéro';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Champ mot de passe
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mot de passe',
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
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppFonts.roboto,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Votre mot de passe',
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
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppGrey.grey600,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Bouton de connexion
                CustomButton(
                  text: 'Se connecter',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 80),

                // Mot de passe oublié
                GestureDetector(
                  onTap: () {
                    // Navigation vers récupération mot de passe
                  },
                  child: Text(
                    'Mot de passe oublier',
                    style: TextStyle(
                      color: AppGreen.green500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.roboto,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Pas de compte
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pas de compte ? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: AppFonts.roboto,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigation vers inscription
                      },
                      child: Text(
                        'J\'ai pas de compte !',
                        style: TextStyle(
                          color: AppGreen.green500,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.roboto,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
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

      // Navigation vers la page suivante
      Get.offAllNamed('/home');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
