import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class AuthHero extends StatelessWidget {
  final String heading;
  final String subtitle;

  const AuthHero({
    super.key,
    required this.heading,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 52.h,
        left: 24.w,
        right: 24.w,
        bottom: 48.h,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.authHeroGradient,
      ),

      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Positioned(
            top: -10.h,
            right: -10.w,
            child: Opacity(
              opacity: 0.07,
              child: SvgPicture.asset(
                AppAssets.crossDecor,
                width: 100.w,
                height: 100.w,
              ),
            ),
          ),

          // ============================================
          // DECORATIVE SVG 2 — Bottom left circles
          // Sirf visual decoration
          // app_assets.dart → circlesDecor
          // ============================================
          Positioned(
            bottom: -10.h,
            left: -10.w,
            child: Opacity(
              opacity: 0.05,
              child: SvgPicture.asset(
                AppAssets.circlesDecor,
                width: 60.w,
                height: 60.w,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.heroLogoOverlay,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.heroLogoBorder,
                        width: 1.5,
                      ),
                    ),

                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.logoIcon,
                        width: 20.w,
                        height: 20.w,
                        colorFilter: ColorFilter.mode(
                          AppColors.heroText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.titleWhite,
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Text(
                heading,
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.heroText,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                subtitle,
                style: AppTextStyles.hintWhite.copyWith(height: 1.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}