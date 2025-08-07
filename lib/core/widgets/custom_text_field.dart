import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isPhone;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? width;
  final double? height;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.isPassword = false,
    this.isPhone = false,
    this.keyboardType,
    this.onChange,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 339,
      height: widget.height ?? 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFDDE2E5), width: 1),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType:
            widget.keyboardType ??
            (widget.isPhone ? TextInputType.phone : TextInputType.text),
        onChanged: widget.onChange,
        validator: widget.validator,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        style: TextStyle(
          fontFamily: AppFonts.roboto,
          fontSize: 16,
          color: AppGrey.grey900,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: AppFonts.roboto,
            fontSize: 16,
            color: AppGrey.grey700,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: AppFonts.roboto,
            fontSize: 16,
            color: AppGrey.grey900,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              widget.isPassword ? _buildPasswordToggle() : widget.suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            top: 13,
            right: 14,
            bottom: 13,
            left: 14,
          ),
          filled: false,
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        size: 20,
        color: AppGrey.grey900,
      ),
    );
  }
}
