import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/medicine_controller.dart';

class ProgressCard extends StatelessWidget {
  final MedicineController ctrl;
  const ProgressCard({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total = ctrl.totalCount;
      final taken = ctrl.takenCount;
      final progress = total == 0 ? 0.0 : taken / total;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.todayProgress, style: AppTextStyles.progressLabel),
              Text(
                '$taken of $total taken',
                style: AppTextStyles.progressLabel.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: AppColors.progressTrack,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _StatChip(
                count: ctrl.takenCount,
                label: AppStrings.taken,
                numColor: AppColors.green,
                bgColor: AppColors.greenBg,
              ),
              SizedBox(width: 6.w),
              _StatChip(
                count: ctrl.pendingCount,
                label: AppStrings.pending,
                numColor: AppColors.orange,
                bgColor: AppColors.orangeBg,
              ),
              SizedBox(width: 6.w),
              _StatChip(
                count: ctrl.missedCount,
                label: AppStrings.missed,
                numColor: AppColors.primary,
                bgColor: AppColors.blueLightBg,
              ),
            ],
          ),
        ],
      ),
    );
    },);
  }
}

class _StatChip extends StatelessWidget {
  final int count;
  final String label;
  final Color numColor;
  final Color bgColor;

  const _StatChip({
    required this.count,
    required this.label,
    required this.numColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text('$count', style: AppTextStyles.statNum.copyWith(color: numColor)),
            SizedBox(height: 1.h),
            Text(label, style: AppTextStyles.statLbl),
          ],
        ),
      ),
    );
  }
}
