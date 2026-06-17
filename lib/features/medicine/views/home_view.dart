import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/medicine_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/medicine_row.dart';
import '../widgets/next_dose_card.dart';
import '../widgets/progress_card.dart';
import '../widgets/streak_row.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<MedicineController>();
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (ctrl.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Header — greeting + date
                HomeHeader(
                  userName: authCtrl.currentUser.value?.name ?? '',
                ),

                // ── 2. Next dose hero card
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                  child: NextDoseCard(ctrl: ctrl),
                ),

                // ── 3. Progress card
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: ProgressCard(ctrl: ctrl),
                ),

                // ── 4. Streak row
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: StreakRow(streak: ctrl.streak.value),
                ),

                // ── 5. Today's medicines title
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
                  child: Text(
                    AppStrings.todayMeds,
                    style: AppTextStyles.sectionTitle,
                  ),
                ),

                // ── 6. Medicine list
                ctrl.todayLogs.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: Text(
                            AppStrings.noMedsToday,
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      )
                    : Column(
                        children: ctrl.todayLogs
                            .map((log) => MedicineRow(log: log, ctrl: ctrl))
                            .toList(),
                      ),

                // Bottom padding for nav bar
                SizedBox(height: 100.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}
