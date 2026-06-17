import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class StreakRow extends StatelessWidget {
  final int streak;
  const StreakRow({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.amberBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.amberBorder),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.flameIcon,
            width: 22.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF9A825),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$streak days 🔥', style: AppTextStyles.streakNum),
              SizedBox(height: 1.h),
              Text(AppStrings.currentStreak, style: AppTextStyles.streakLbl),
            ],
          ),
        ],
      ),
    );
  }
}
