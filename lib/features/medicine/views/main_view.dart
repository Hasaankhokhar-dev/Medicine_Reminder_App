import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:med_reminder_app/core/constants/app_colors.dart';
import 'package:med_reminder_app/features/medicine/views/schedule_view.dart';
import 'package:med_reminder_app/features/medicine/views/settings_view.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import 'add_medicine_view.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _controller = NotchBottomBarController(index: 0);
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const ScheduleView(),
    const AddMedicineView(),
    const SettingsView(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: AppColors.white,
          showLabel: true,
          shadowElevation: 8,
          kBottomRadius: 28.r,
          kIconSize: 22.w,
          notchColor: AppColors.primary,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppAssets.homeNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                AppAssets.homeNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              itemLabel: AppStrings.home,
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppAssets.scheduleNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                AppAssets.scheduleNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              itemLabel: AppStrings.schedule,
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppAssets.addNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                AppAssets.addNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              itemLabel: AppStrings.add,
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                AppAssets.settingsNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.textHint,
                  BlendMode.srcIn,
                ),
              ),
              activeItem: SvgPicture.asset(
                AppAssets.settingsNavIcon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              itemLabel: AppStrings.settings,
            ),
          ],
        ),
      ),
    );
  }
}