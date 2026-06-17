import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/medicine_controller.dart';
import '../models/dose_log_model.dart';
import '../models/medicine_model.dart';
import '../views/medicine_detail_view.dart';

class MedicineRow extends StatelessWidget {
  final DoseLogModel log;
  final MedicineController ctrl;
  const MedicineRow({super.key, required this.log, required this.ctrl});

  Color get _dotColor {
    switch (log.status) {
      case MedicineStatus.taken:   return AppColors.green;
      case MedicineStatus.pending: return AppColors.orange;
      case MedicineStatus.missed:  return AppColors.error;
    }
  }

  String get _badgeLabel {
    switch (log.status) {
      case MedicineStatus.taken:   return AppStrings.taken;
      case MedicineStatus.pending: return AppStrings.pending;
      case MedicineStatus.missed:  return AppStrings.missed;
    }
  }

  Color get _badgeColor {
    switch (log.status) {
      case MedicineStatus.taken:   return AppColors.green;
      case MedicineStatus.pending: return AppColors.orange;
      case MedicineStatus.missed:  return AppColors.error;
    }
  }

  Color get _badgeBg {
    switch (log.status) {
      case MedicineStatus.taken:   return AppColors.greenBg;
      case MedicineStatus.pending: return AppColors.orangeBg;
      case MedicineStatus.missed:  return const Color(0xFFFFEBEE);
    }
  }

  String _formatTime(String time24) {
    final parts = time24.split(':');
    final dt = DateTime(0, 0, 0, int.parse(parts[0]), int.parse(parts[1]));
    return DateFormat('h:mm a').format(dt);
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
    return GestureDetector(
      onTap: () {
         final medicine = ctrl.medicines.firstWhere((m) => m.id == log.medicineId);
         Get.to(() => MedicineDetailView(medicine: medicine));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 8.w, height: 8.w,
              decoration: BoxDecoration(
                color: _dotColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${log.medicineName} ${log.dosage}',
                    style: AppTextStyles.medName,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${_formatTime(log.scheduledTime)} · ${_typeLabel(log.type)}',
                    style: AppTextStyles.medSub,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: _badgeBg,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                _badgeLabel,
                style: AppTextStyles.badge.copyWith(color: _badgeColor),
              ),
            ),
            SizedBox(width: 4.w),
            SvgPicture.asset(
              AppAssets.chevronRight,
              width: 14.w,
              colorFilter: ColorFilter.mode(
                AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
