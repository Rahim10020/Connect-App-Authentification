import 'package:connect_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool showText;

  const LogoWidget({super.key, required this.size, this.showText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: SvgPicture.asset(
            AppAssets.logo1,
            width: size,
            height: size,
            colorFilter: const ColorFilter.mode(
              AppGreen.green500,
              BlendMode.srcIn,
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 16),
          Text(
            'from',
            style: TextStyle(
              fontSize: 14,
              color: AppGrey.grey200,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: SvgPicture.asset(
              AppAssets.logo2,
              width: size,
              height: size,
              colorFilter: const ColorFilter.mode(
                AppGreen.green500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
