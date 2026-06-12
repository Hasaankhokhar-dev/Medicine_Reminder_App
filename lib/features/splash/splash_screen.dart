// lib/features/splash/view/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.authHeroGradient,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.heroLogoOverlay,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.heroLogoBorder,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.logoIcon,
                    width: 40.w,
                    height: 40.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                AppStrings.appName,
                style: AppTextStyles.titleWhite.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Text(
                  AppStrings.splashSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.hintWhite.copyWith(
                    fontSize: 13.sp,
                    height: 1.6,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FeatureChip(
                    label: AppStrings.chipReminders,
                  ),
                  SizedBox(width: 8.w),
                  _FeatureChip(
                    label: AppStrings.chipStats,
                  ),
                  SizedBox(width: 8.w),
                  _FeatureChip(
                    label: AppStrings.chipAlerts,
                  ),
                ],
              ),
              const Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    child: InkWell(
                      onTap: () {
                        // TODO: Get.offAllNamed(AppRoutes.login);
                      },
                      borderRadius: BorderRadius.circular(14.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Center(
                          child: Text(
                            AppStrings.getStarted,
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String label;
  const _FeatureChip({ required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0x33FFFFFF),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xCCFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}