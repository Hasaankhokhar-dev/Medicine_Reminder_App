import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  const HomeHeader({super.key, required this.userName});

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return AppStrings.goodMorning;
    if (h < 17) return AppStrings.goodAfternoon;
    return AppStrings.goodEvening;
  }

  String get _dateLabel => DateFormat('EEE, d MMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 22.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_greeting, style: AppTextStyles.greeting),
              SizedBox(height: 2.h),
              Text('$userName 👋', style: AppTextStyles.greetingName),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(_dateLabel, style: AppTextStyles.datePill),
          ),
        ],
      ),
    );
  }
}
