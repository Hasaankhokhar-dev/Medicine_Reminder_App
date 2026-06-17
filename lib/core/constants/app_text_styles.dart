import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const _font = 'PlusJakartaSans';

  // Auth hero heading — "Welcome back!
  static TextStyle get h2 => TextStyle(
    fontFamily: _font,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.heroText,
    letterSpacing: -0.3,
  );

  // Form field labels — "Email Address", "Password"
  static TextStyle get bodyMedium  => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Secondary text — "Don't have an account?"
  static TextStyle get bodySmall => TextStyle(
    fontFamily: _font,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

// Button labels — "Sign In"
  static TextStyle get button => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // TextField placeholder — "example@gmail.com"
  static TextStyle get hint => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.textHint,
  );

  // Logo text — "MedRemind"
  static TextStyle get titleWhite => TextStyle(
    fontFamily: _font,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.3,
  );

  // Hero subtitle — "Sign in to manage..."
  static TextStyle get hintWhite => TextStyle(
    fontFamily: _font,
    fontSize: 12.sp,
    color: AppColors.heroSubtext,
  );

  // Forgot password link — "Forgot password?"
  static TextStyle get forgotPassword => TextStyle(
    fontFamily: _font,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // OR divider text — "or continue with"
  static TextStyle get orDivider => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    color: AppColors.textHint,
  );
  // Sign Up link — "Sign Up"
  static TextStyle get signUpLink => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

// Home header — "Good morning,"
  static TextStyle get greeting => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: Colors.white.withOpacity(0.75),
  );

// Home header — "Muhammad 👋"
  static TextStyle get greetingName => TextStyle(
    fontFamily: _font,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.3,
  );

// Home header — "Fri, 5 Jun" date pill
  static TextStyle get datePill => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

// Section title — "Today's medicines", "Reminder Times"
  static TextStyle get sectionTitle => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

// Medicine list row — "Paracetamol 500mg"
  static TextStyle get medName => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

// Medicine list row — "8:00 AM · Tablet"
  static TextStyle get medSub => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    color: AppColors.textHint,
  );

// Status badge — "Taken", "Pending", "Missed"
  static TextStyle get badge => TextStyle(
    fontFamily: _font,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );

// Next dose card — "Paracetamol 500mg"
  static TextStyle get ndhName => TextStyle(
    fontFamily: _font,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.3,
  );

// Next dose card — "1 Tablet · After meal"
  static TextStyle get ndhSub => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    color: Colors.white.withOpacity(0.75),
  );

// Next dose card — "2:00"
  static TextStyle get ndhTime => TextStyle(
    fontFamily: _font,
    fontSize: 17.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

// Next dose card — "AM" / "PM"
  static TextStyle get ndhTimeAmPm => TextStyle(
    fontFamily: _font,
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.75),
  );

// Next dose card — "NEXT DOSE" label
  static TextStyle get ndhLabel => TextStyle(
    fontFamily: _font,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white.withOpacity(0.70),
    letterSpacing: 0.1,
  );

// Progress card — "Today's progress", "3 of 5 taken"
  static TextStyle get progressLabel => TextStyle(
    fontFamily: _font,
    fontSize: 12.sp,
    color: AppColors.textMid,
  );

// Progress stat chip — "3", "2", "0" numbers
  static TextStyle get statNum => TextStyle(
    fontFamily: _font,
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
  );

// Progress stat chip — "Taken", "Pending", "Missed" labels
  static TextStyle get statLbl => TextStyle(
    fontFamily: _font,
    fontSize: 10.sp,
    color: AppColors.textHint,
  );

// Streak row — "7 days 🔥"
  static TextStyle get streakNum => TextStyle(
    fontFamily: _font,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.amberStrong,
  );

// Streak row — "Current streak — keep it up!"
  static TextStyle get streakLbl => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    color: AppColors.amberText,
  );

  // Form field label — "MEDICINE NAME"
  static TextStyle get formLabel => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 0.05,
  );

// Type chip label — "Tablet"
  static TextStyle get chipLabel => TextStyle(
    fontFamily: _font,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textHint,
  );

// Day chip label — "M", "T"
  static TextStyle get dayChip => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

// Screen header title
  static TextStyle get screenHeader => TextStyle(
    fontFamily: _font,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}