import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.width = 339,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? AppGrey.grey300 : AppGreen.green500,
          foregroundColor: isOutlined ? AppGrey.grey900 : Colors.white,
          side: null,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        child:
            isLoading
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppGreen.green500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Chargement',
                      style: TextStyle(
                        color: AppGreen.green500,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.roboto,
                      ),
                    ),
                  ],
                )
                : Text(
                  text,
                  style: TextStyle(
                    color: isOutlined ? AppGrey.grey900 : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.roboto,
                  ),
                ),
      ),
    );
  }
}
