import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSelectionPage extends StatefulWidget {
  const ProfileSelectionPage({super.key});

  @override
  State<ProfileSelectionPage> createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage> {
  String? selectedProfile;

  final List<ProfileOption> profileOptions = [
    ProfileOption(
      id: 'eleve',
      title: 'Élève',
      icon: Icons.people, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'etudiant',
      title: 'Étudiant',
      icon: Icons.school, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'repetiteur',
      title: 'Repetiteur',
      icon: Icons.person_outline, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'repititeur',
      title: 'Répititeur',
      icon: Icons.person_outline, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'parent',
      title: 'Parent d\'élève',
      icon: Icons.visibility, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'livreur',
      title: 'Livreur',
      icon: Icons.delivery_dining, // Remplace par ton icône
    ),
    ProfileOption(
      id: 'conducteur',
      title: 'Conducteur',
      icon: Icons.local_shipping, // Remplace par ton icône
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            // Indicateur de progression
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppGreen.green500,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Titre
            Text(
              'Choisez votre profile\nd\'utilisation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.roboto,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 40),

            // Grille des options
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: profileOptions.length,
                itemBuilder: (context, index) {
                  final option = profileOptions[index];
                  final isSelected = selectedProfile == option.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfile = option.id;
                      });

                      // Naviguer vers la page suivante après sélection
                      Future.delayed(const Duration(milliseconds: 200), () {
                        Get.toNamed('/register', arguments: option.id);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppGreen.green100 : AppGrey.grey300,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            isSelected
                                ? Border.all(color: AppGreen.green500, width: 2)
                                : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            option.icon,
                            size: 40,
                            color:
                                isSelected ? AppGreen.green500 : Colors.black,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            option.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  isSelected ? AppGreen.green500 : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFonts.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOption {
  final String id;
  final String title;
  final IconData icon;

  ProfileOption({required this.id, required this.title, required this.icon});
}
