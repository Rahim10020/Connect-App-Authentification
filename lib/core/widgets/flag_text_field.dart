import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class FlagTextField extends StatelessWidget {
  final String selectedCountry;
  final TextEditingController controller;
  final void Function(String?)? onChanged;

  const FlagTextField({
    super.key,
    this.selectedCountry = 'FR',
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Prefix avec drapeau et code pays
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppGrey.grey300,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppGrey.grey400),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                selectedCountry == 'FR' ? AppAssets.france : AppAssets.togo,
                width: 24,
                height: 16,
              ),
              const SizedBox(width: 4),
              DropdownButton<String>(
                value: selectedCountry,
                underline: Container(),
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                items: const [
                  DropdownMenuItem(value: 'FR', child: Text('FR')),
                  DropdownMenuItem(value: 'TG', child: Text('TG')),
                ],
                onChanged: onChanged,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Champ de saisie étendu
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppGrey.grey400),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  selectedCountry == 'FR' ? '+33 ' : '+228 ',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppFonts.kanit,
                    color: AppGrey.grey900,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.kanit,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Votre numéro',
                      hintStyle: TextStyle(
                        color: AppGrey.grey700,
                        fontSize: 16,
                        fontFamily: AppFonts.kanit,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
