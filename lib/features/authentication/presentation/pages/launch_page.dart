import 'package:connect_app/core/constants/app_assets.dart';
import 'package:connect_app/core/constants/app_colors.dart';
import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes puis naviguer vers onboarding
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Spacer pour centrer le logo principal
          const Spacer(flex: 2),

          // Logo principal centré
          Center(
            child: Container(
              width: 80,
              height: 80,
              child: SvgPicture.asset(
                AppAssets.logo1,
                width: 80,
                height: 80,
                colorFilter: const ColorFilter.mode(
                  AppGreen.green500,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          const Spacer(flex: 2),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'from',
                style: TextStyle(
                  fontSize: 14,
                  color: AppGrey.grey500,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFonts.roboto,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 24,
                child: SvgPicture.asset(
                  AppAssets.logo2,
                  width: 60,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppGreen.green500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
