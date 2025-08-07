import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:connect_app/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? textColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 339,
      height: height ?? 48,

      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF00D471),
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          padding: const EdgeInsets.only(
            top: 10,
            left: 37,
            right: 37,
            bottom: 10,
          ),
        ),
        child:
            isLoading
                ? Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Chargement',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.roboto,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
                : Text(
                  text,
                  style: TextStyle(
                    fontFamily: AppFonts.roboto,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
      ),
    );
  }
}
