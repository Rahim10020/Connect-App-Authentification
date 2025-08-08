import 'package:connect_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final Color? color;

  const LogoWidget({super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: SvgPicture.asset(
        AppAssets.logo1,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          color ?? AppGreen.green500,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
