import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/medicine_controller.dart';
import '../models/medicine_model.dart';

class AddMedicineView extends StatelessWidget {
  const AddMedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<MedicineController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _AddHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FormLabel(AppStrings.medicineName),
                    SizedBox(height: 6.h),
                    _FormInput(
                      controller: ctrl.nameCtrl,
                      hint: AppStrings.medicineNameHint,
                    ),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.dosage),
                    SizedBox(height: 6.h),
                    _FormInput(
                      controller: ctrl.dosageCtrl,
                      hint: AppStrings.dosageHint,
                    ),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.medicineType),
                    SizedBox(height: 8.h),
                    _TypeChipsRow(ctrl: ctrl),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.medicineImage),
                    SizedBox(height: 8.h),
                    _ImageUploadBox(),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.reminderTimes),
                    SizedBox(height: 8.h),
                    _TimeChipsGrid(ctrl: ctrl),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.repeatDays),
                    SizedBox(height: 8.h),
                    _DayChipsRow(ctrl: ctrl),
                    SizedBox(height: 14.h),

                    _FormLabel(AppStrings.notes),
                    SizedBox(height: 6.h),
                    _FormInput(
                      controller: ctrl.notesCtrl,
                      hint: AppStrings.notesHint,
                    ),
                    SizedBox(height: 24.h),

                    _SaveButton(ctrl: ctrl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
//  Blue header
// ══════════════════════════════════════════
class _AddHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              AppAssets.arrowBackIcon,
              width: 20.w,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(AppStrings.addMedicine, style: AppTextStyles.screenHeader),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
//  Form label — "MEDICINE NAME"
// ══════════════════════════════════════════
class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(), style: AppTextStyles.formLabel);
  }
}

// ══════════════════════════════════════════
//  Text input field
// ══════════════════════════════════════════
class _FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _FormInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'PlusJakartaSans',
        fontSize: 13.sp,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.hint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
//  Type chips — Tablet / Capsule / Syrup / Injection
//  Original: padding 10px 6px, icon 20px, label 10px
// ══════════════════════════════════════════
class _TypeChipsRow extends StatelessWidget {
  final MedicineController ctrl;
  const _TypeChipsRow({required this.ctrl});

  String _iconFor(MedicineType type) {
    switch (type) {
    // ✅ Tablet ke liye different icon — pillIcon missing tha
      case MedicineType.tablet:    return AppAssets.pillIcon;
      case MedicineType.capsule:   return AppAssets.capsuleIcon;
      case MedicineType.syrup:     return AppAssets.syrupIcon;
      case MedicineType.injection: return AppAssets.injectionIcon;
    }
  }

  String _labelFor(MedicineType type) {
    switch (type) {
      case MedicineType.tablet:    return AppStrings.typeTablet;
      case MedicineType.capsule:   return AppStrings.typeCapsule;
      case MedicineType.syrup:     return AppStrings.typeSyrup;
      case MedicineType.injection: return AppStrings.typeInjection;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: MedicineType.values.map((type) {
        final isActive = ctrl.selectedType.value == type;
        final isLast   = type == MedicineType.values.last;

        return Expanded(
          child: GestureDetector(
            onTap: () => ctrl.selectType(type),
            child: Container(
              margin: EdgeInsets.only(right: isLast ? 0 : 6.w),
              // ✅ Original: padding 10px 6px
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 6.w,
              ),
              decoration: BoxDecoration(
                color: isActive ? AppColors.blueLightBg : AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.border,
                  width: isActive ? 2 : 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    _iconFor(type),
                    // ✅ Original: 20px
                    width: 20.w,
                    height: 20.w,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.primary : AppColors.textHint,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _labelFor(type),
                    style: AppTextStyles.chipLabel.copyWith(
                      // ✅ Original: 10px
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: isActive ? AppColors.primary : AppColors.textHint,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ));
  }
}

// ══════════════════════════════════════════
//  Image upload — full width + dashed border
//  Original: full width, dashed border, padding 14px
// ══════════════════════════════════════════
class _ImageUploadBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Cloudinary image picker
      },
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.primaryMid,
          radius: 12.r,
        ),
        child: Container(
          width: double.infinity,
          // ✅ Original: padding 14px
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.cameraIcon,
                width: 24.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryMid,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                AppStrings.tapToAddPhoto,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryMid,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashed border painter
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) => false;
}

// ══════════════════════════════════════════
//  Time chips — Column + Row (GridView nahi)
//  Original: padding 8px 10px, gap 6px
//  ✅ GridView ki jagah manual Column+Row
//     taake extra space na aaye
// ══════════════════════════════════════════
class _TimeChipsGrid extends StatelessWidget {
  final MedicineController ctrl;
  const _TimeChipsGrid({required this.ctrl});

  static const _slots = [
    {'label': 'Morning 8 AM',   'time': '08:00', 'icon': 'sun'},
    {'label': 'Afternoon 2 PM', 'time': '14:00', 'icon': 'clock'},
    {'label': 'Evening 7 PM',   'time': '19:00', 'icon': 'sunset'},
    {'label': 'Night 10 PM',    'time': '22:00', 'icon': 'moon'},
  ];

  String _iconFor(String type) {
    switch (type) {
      case 'sun':    return AppAssets.sunIcon;
      case 'clock':  return AppAssets.clockIcon;
      case 'sunset': return AppAssets.sunClockIcon;
      case 'moon':   return AppAssets.moonIcon;
      default:       return AppAssets.clockIcon;
    }
  }

  Widget _chip(
      BuildContext context,
      Map<String, String> slot,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // ✅ Original: padding 8px 10px
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                _iconFor(slot['icon']!),
                width: 16.w,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.white : AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  slot['label']!,
                  style: AppTextStyles.chipLabel.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        // Row 1 — Morning + Afternoon
        Row(
          children: [
            _chip(
              context,
              _slots[0],
              ctrl.selectedTimes.contains(_slots[0]['time']),
                  () => ctrl.toggleTime(_slots[0]['time']!),
            ),
            SizedBox(width: 6.w),
            _chip(
              context,
              _slots[1],
              ctrl.selectedTimes.contains(_slots[1]['time']),
                  () => ctrl.toggleTime(_slots[1]['time']!),
            ),
          ],
        ),
        // ✅ gap 6px between rows
        SizedBox(height: 6.h),
        // Row 2 — Evening + Night
        Row(
          children: [
            _chip(
              context,
              _slots[2],
              ctrl.selectedTimes.contains(_slots[2]['time']),
                  () => ctrl.toggleTime(_slots[2]['time']!),
            ),
            SizedBox(width: 6.w),
            _chip(
              context,
              _slots[3],
              ctrl.selectedTimes.contains(_slots[3]['time']),
                  () => ctrl.toggleTime(_slots[3]['time']!),
            ),
          ],
        ),
      ],
    ));
  }
}

// ══════════════════════════════════════════
//  Day chips — M T W T F S S
//  Original: width 32px height 32px, gap 5px
// ══════════════════════════════════════════
class _DayChipsRow extends StatelessWidget {
  final MedicineController ctrl;
  const _DayChipsRow({required this.ctrl});

  static const _days = [
    {'label': 'M', 'day': 1},
    {'label': 'T', 'day': 2},
    {'label': 'W', 'day': 3},
    {'label': 'T', 'day': 4},
    {'label': 'F', 'day': 5},
    {'label': 'S', 'day': 6},
    {'label': 'S', 'day': 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _days.map((d) {
        final isOn = ctrl.selectedDays.contains(d['day']);

        return GestureDetector(
          onTap: () => ctrl.toggleDay(d['day'] as int),
          child: Container(
            // ✅ Original: 32px x 32px
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: isOn ? AppColors.primary : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isOn ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                d['label'] as String,
                style: AppTextStyles.dayChip.copyWith(
                  // ✅ Original: 11px font
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: isOn ? AppColors.white : AppColors.primary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ));
  }
}

// ══════════════════════════════════════════
//  Save button
// ══════════════════════════════════════════
class _SaveButton extends StatelessWidget {
  final MedicineController ctrl;
  const _SaveButton({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ctrl.isSaving.value ? null : ctrl.saveMedicine,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primaryMid,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        child: ctrl.isSaving.value
            ? SizedBox(
          height: 20.h,
          width: 20.h,
          child: const CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        )
            : Text(AppStrings.saveMedicine, style: AppTextStyles.button),
      ),
    ));
  }
}