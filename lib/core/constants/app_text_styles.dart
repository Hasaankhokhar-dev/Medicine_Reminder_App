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

}