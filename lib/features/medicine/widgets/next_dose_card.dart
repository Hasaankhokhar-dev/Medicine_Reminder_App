import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/medicine_controller.dart';
import '../models/medicine_model.dart';

class NextDoseCard extends StatelessWidget {
  final MedicineController ctrl;
  const NextDoseCard({super.key, required this.ctrl});

  String _formatTime(String time24) {
    final parts = time24.split(':');
    final dt = DateTime(0, 0, 0, int.parse(parts[0]), int.parse(parts[1]));
    return DateFormat('h:mm').format(dt);
  }

  String _amPm(String time24) {
    return int.parse(time24.split(':')[0]) < 12 ? 'AM' : 'PM';
  }

  String _typeLabel(MedicineType type) {
    switch (type) {
      case MedicineType.tablet:    return 'Tablet';
      case MedicineType.capsule:   return 'Capsule';
      case MedicineType.syrup:     return 'Syrup';
      case MedicineType.injection: return 'Injection';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dose = ctrl.nextDose;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20, right: -20,
            child: Container(
              width: 100.w, height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -30, right: 40,
            child: Container(
              width: 70.w, height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.clockIcon,
                    width: 12.w,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.70),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    AppStrings.nextDose.toUpperCase(),
                    style: AppTextStyles.ndhLabel,
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              dose == null
                  ? Text(
                AppStrings.noDoseNext,
                style: AppTextStyles.ndhName,
              )
                  : Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46.w, height: 46.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.30),
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.pillIcon,
                            width: 22.w,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${dose.medicineName} ${dose.dosage}',
                              style: AppTextStyles.ndhName,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '1 ${_typeLabel(dose.type)} · After meal',
                              style: AppTextStyles.ndhSub,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _formatTime(dose.scheduledTime),
                              style: AppTextStyles.ndhTime,
                            ),
                            Text(
                              _amPm(dose.scheduledTime),
                              style: AppTextStyles.ndhTimeAmPm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ctrl.markTaken(dose.id),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9.h),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.markTaken,
                                style: AppTextStyles.button.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ctrl.snooze(dose.id),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.snooze,
                                style: AppTextStyles.button.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
