import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/constants/app_icons.dart';
import 'package:connect_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  String? selectedImage;
  String _visibility = 'Tous le monde';

  // Données des pages précédentes
  Map<String, dynamic>? registrationData;

  @override
  void initState() {
    super.initState();
    // Récupérer les données depuis la page précédente
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
            // Indicateur de progression - 5ème étape
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = MediaQuery.of(context).size.height;
              final isSmallScreen =
                  screenHeight < 700; // Détection petits écrans

              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - 200,
                ), // Hauteur minimum moins AppBar et padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Espace adaptatif en haut
                    SizedBox(height: isSmallScreen ? 16 : 30),

                    // Titre
                    Text(
                      'Photo de profil',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.kanit,
                        height: 1.2,
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 32 : 60),

                    // Avatar et bouton d'ajout
                    Center(
                      child: Column(
                        children: [
                          // Avatar avec image par défaut
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppGreen.green200,
                              shape: BoxShape.circle,
                            ),
                            child:
                                selectedImage != null
                                    ? ClipOval(
                                      child: Image.network(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return _buildDefaultAvatar();
                                        },
                                      ),
                                    )
                                    : _buildDefaultAvatar(),
                          ),

                          const SizedBox(height: 20),

                          // Bouton Ajouter une photo
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppGreen.green50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Ajouter une photo',
                                style: TextStyle(
                                  color: AppGreen.green500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFonts.roboto,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Espace adaptatif après avatar
                    SizedBox(height: isSmallScreen ? 32 : 60),

                    // Option de visibilité
                    GestureDetector(
                      onTap: _showVisibilityModal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppGrey.grey400),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Qui peut voir ma photo de profil',
                                    style: TextStyle(
                                      color: AppGrey.grey900,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.roboto,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _visibility,
                                    style: TextStyle(
                                      color: AppGrey.grey600,
                                      fontSize: 14,
                                      fontFamily: AppFonts.roboto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: AppGrey.grey600),
                          ],
                        ),
                      ),
                    ),

                    // Espace flexible ou fixe selon la taille d'écran
                    if (isSmallScreen)
                      const SizedBox(
                        height: 32,
                      ) // Espace fixe sur petits écrans
                    else
                      const Spacer(), // Spacer seulement sur grands écrans
                    // Bouton Continuer
                    CustomButton(text: 'Continuer', onPressed: _handleContinue),

                    // Espace adaptatif en bas
                    SizedBox(height: isSmallScreen ? 16 : 40),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 145,
      height: 145,
      child: Image.asset(AppAssets.maleAvatar, fit: BoxFit.contain),
    );
  }

  void _pickImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo de profile',
                  style: TextStyle(
                    color: AppGrey.grey900,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.roboto,
                  ),
                ),
                const SizedBox(height: 32),

                // Options Camera et Gallery
                Row(
                  children: [
                    // Option Camera
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        _selectFromCamera();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: AppGreen.green500,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppIcons.icCamera,
                              color: Colors.white,
                              fit: BoxFit.contain,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFonts.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 40),

                    // Option Gallery
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        _selectFromGallery();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: AppGreen.green500,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppIcons.icGallery,
                              color: Colors.white,
                              fit: BoxFit.contain,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFonts.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
    );
  }

  void _selectFromCamera() {
    // Implémenter la sélection depuis la caméra
    Get.snackbar(
      'Caméra',
      'Ouverture de la caméra...',
      backgroundColor: AppGreen.green500,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _selectFromGallery() {
    // Implémenter la sélection depuis la galerie
    Get.snackbar(
      'Galerie',
      'Ouverture de la galerie...',
      backgroundColor: AppGreen.green500,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _showVisibilityModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qui peut voir ma photo de profil',
                  style: TextStyle(
                    color: AppGrey.grey900,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.roboto,
                  ),
                ),
                const SizedBox(height: 24),

                // Options de visibilité
                _buildVisibilityOption('Tous le monde'),
                const SizedBox(height: 16),
                _buildVisibilityOption('Mes contacts'),
                const SizedBox(height: 16),
                _buildVisibilityOption('Personne'),

                const SizedBox(height: 40),
              ],
            ),
          ),
    );
  }

  Widget _buildVisibilityOption(String option) {
    final isSelected = _visibility == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _visibility = option;
        });
        Get.back();
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppGreen.green500 : AppGrey.grey500,
                width: 2,
              ),
            ),
            child:
                isSelected
                    ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppGreen.green500,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 12),
          Text(
            option,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: AppFonts.roboto,
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    // Ajouter les données de photo de profil
    Map<String, dynamic> finalData = {
      ...?registrationData,
      'profilePhoto': selectedImage,
      'photoVisibility': _visibility,
    };

    // Naviguer vers la page suivante ou finaliser l'inscription
    Get.offAllNamed('/home', arguments: finalData);
  }
}
