  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:get/get.dart';
  import '../../../core/constants/app_assets.dart';
  import '../../../core/constants/app_colors.dart';
  import '../../../core/constants/app_strings.dart';
  import '../../../core/constants/app_text_styles.dart';
  import '../../../core/widgets/primary_button.dart';
  import '../controllers/auth_controller.dart';
  import '../widgets/auth_hero.dart';
  
  class SignupView extends StatefulWidget {
    const SignupView({super.key});
  
    @override
    State<SignupView> createState() => _SignupViewState();
  }
  
  class _SignupViewState extends State<SignupView> {
    final _nameCtrl  = TextEditingController();
    final _emailCtrl = TextEditingController();
    final _passCtrl  = TextEditingController();
    bool _obscurePass = true;
  
    @override
    void dispose() {
      _nameCtrl.dispose();
      _emailCtrl.dispose();
      _passCtrl.dispose();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      final ctrl = Get.find<AuthController>();
  
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
  
            AuthHero(
              heading: AppStrings.createYourAccount,
              subtitle: AppStrings.signupSubtitle,
            ),
  
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: -22.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
  
                      Text(
                        AppStrings.fullName.toUpperCase(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textHint,
                          letterSpacing: 0.06,
                        ),
                      ),
                      SizedBox(height: 6.h),
  
                      Obx(() => TextField(
                        controller: _nameCtrl,
                        keyboardType: TextInputType.name,
                        style: AppTextStyles.bodyMedium,
                        onChanged: (_) => ctrl.clearErrors(),
                        decoration: InputDecoration(
                          hintText: AppStrings.nameHint,
                          hintStyle: AppTextStyles.hint,
                          // Person icon — login mein email icon tha
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: SvgPicture.asset(
                              AppAssets.personIcon,
                              width: 18.w,
                              colorFilter: ColorFilter.mode(
                                AppColors.textHint,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          errorText: ctrl.nameError.value.isEmpty
                              ? null
                              : ctrl.nameError.value,
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.error),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.error,
                              width: 1.5,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 16.h),
  
  
                      Text(
                        AppStrings.emailAddress.toUpperCase(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textHint,
                          letterSpacing: 0.06,
                        ),
                      ),
                      SizedBox(height: 6.h),
  
                      Obx(() => TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        style: AppTextStyles.bodyMedium,
                        onChanged: (_) => ctrl.clearErrors(),
                        decoration: InputDecoration(
                          hintText: AppStrings.emailHint,
                          hintStyle: AppTextStyles.hint,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: SvgPicture.asset(
                              AppAssets.emailIcon,
                              width: 18.w,
                              colorFilter: ColorFilter.mode(
                                AppColors.textHint,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          errorText: ctrl.emailError.value.isEmpty
                              ? null
                              : ctrl.emailError.value,
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.error),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.error,
                              width: 1.5,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 16.h),
                      Text(
                        AppStrings.password.toUpperCase(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textHint,
                          letterSpacing: 0.06,
                        ),
                      ),
                      SizedBox(height: 6.h),
  
                      Obx(() => TextField(
                        controller: _passCtrl,
                        obscureText: _obscurePass,
                        style: AppTextStyles.bodyMedium,
                        onChanged: (value) {
                          ctrl.clearErrors();
                        },
                        decoration: InputDecoration(
                          hintText: AppStrings.passHint,
                          hintStyle: AppTextStyles.hint,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: SvgPicture.asset(
                              AppAssets.lockIcon,
                              width: 18.w,
                              colorFilter: ColorFilter.mode(
                                AppColors.textHint,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                setState(() => _obscurePass = !_obscurePass),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: SvgPicture.asset(
                                _obscurePass
                                    ? AppAssets.eyeOffIcon
                                    : AppAssets.eyeOnIcon,
                                width: 18.w,
                                colorFilter: ColorFilter.mode(
                                  AppColors.textHint,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          errorText: ctrl.passwordError.value.isEmpty
                              ? null
                              : ctrl.passwordError.value,
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: AppColors.error),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: AppColors.error,
                              width: 1.5,
                            ),
                          ),
                        ),
                      )),
  
                      SizedBox(height: 8.h),
                      Obx(() => ctrl.errorMessage.value.isNotEmpty
                          ? Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          ctrl.errorMessage.value,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      )
                          : const SizedBox.shrink()),
  
                      Obx(() => PrimaryButton(
                        label: AppStrings.createAccount,
                        isLoading: ctrl.isLoading.value,
                        onPressed: () => ctrl.signUp(
                          _nameCtrl.text,
                          _emailCtrl.text,
                          _passCtrl.text,
                        ),
                      )),
                      SizedBox(height: 16.h),
  
                      Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              AppStrings.orSignUpWith,
                              style: AppTextStyles.orDivider,
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      SizedBox(height: 16.h),
  
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () => ctrl.signInWithGoogle(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Google colorful icon — colorFilter nahi
                              SvgPicture.asset(
                                AppAssets.googleIcon,
                                width: 18.w,
                                height: 18.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                AppStrings.continueGoogle,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
  
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${AppStrings.termsText}\n',
                            style: AppTextStyles.bodySmall,
                            children: [
                              TextSpan(
                                text: AppStrings.termsLink,
                                style: AppTextStyles.signUpLink.copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.andText,
                                style: AppTextStyles.bodySmall,
                              ),
                              TextSpan(
                                text: AppStrings.privacyLink,
                                style: AppTextStyles.signUpLink.copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            ctrl.clearErrors();
                            ctrl.resetPasswordStrength();
                            Get.back();
                          },
                          child: RichText(
                            text: TextSpan(
                              text: '${AppStrings.haveAccount} ',
                              style: AppTextStyles.bodySmall,
                              children: [
                                TextSpan(
                                  text: AppStrings.loginLink,
                                  style: AppTextStyles.signUpLink,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
