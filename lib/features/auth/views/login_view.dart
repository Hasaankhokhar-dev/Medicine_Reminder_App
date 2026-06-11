import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:med_reminder_app/core/constants/app_assets.dart';
import 'package:med_reminder_app/core/widgets/primary_button.dart';
import 'package:med_reminder_app/features/auth/widgets/auth_hero.dart';
import 'package:med_reminder_app/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ctrl = Get.find<AuthController>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // Password show/hide state
  bool _obscurePass = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            AuthHero(
              heading: AppStrings.welcomeBack,
              subtitle: AppStrings.loginSubtitle,
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, -22.h),
                child: Container(
                  width: double.infinity,
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
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                style: AppTextStyles.bodyMedium,
                                onChanged: (value) => ctrl.clearErrors(),
                                decoration: InputDecoration(
                                  hintText: AppStrings.emailHint,
                                  hintStyle: AppTextStyles.hint,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: SvgPicture.asset(
                                      AppAssets.emailIcon,
                                      width: 17.w,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.textHint,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  errorText: ctrl.emailError.value.isNotEmpty
                                      ? ctrl.emailError.value
                                      : null,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.border,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.error,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.error,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
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
                              TextField(
                                controller: _passCtrl,
                                obscureText: _obscurePass,
                                style: AppTextStyles.bodyMedium,
                                onChanged: (_) => ctrl.clearErrors(),
                                decoration: InputDecoration(
                                  hintText: AppStrings.passHint,
                                  hintStyle: AppTextStyles.hint,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: SvgPicture.asset(
                                      AppAssets.lockIcon,
                                      width: 18.w,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.textHint,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(
                                            () => _obscurePass = !_obscurePass),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: SvgPicture.asset(
                                        _obscurePass
                                            ? AppAssets.eyeOffIcon
                                            : AppAssets.eyeOnIcon,
                                        width: 18.w,
                                        colorFilter: const ColorFilter.mode(
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
                                    borderSide: const BorderSide(
                                        color: AppColors.border),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                        color: AppColors.error),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: AppColors.error,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 6.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AppStrings.forgotPassword,
                              style: AppTextStyles.forgotPassword,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
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
                          label: AppStrings.signIn,
                          isLoading: ctrl.isLoading.value,
                          onPressed: () => ctrl.login(
                            _emailCtrl.text,
                            _passCtrl.text,
                          ),
                        )),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                AppStrings.orContinueWith,
                                style: AppTextStyles.orDivider,
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.border),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _SocialButton(
                          label: AppStrings.signInGoogle,
                          iconPath: AppAssets.googleIcon,
                          onPressed: () => ctrl.signInWithGoogle(),
                        ),
                        SizedBox(height: 24.h),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              ctrl.clearErrors();
                              Get.toNamed(AppRoutes.signup);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: '${AppStrings.noAccount} ',
                                style: AppTextStyles.bodySmall,
                                children: [
                                  TextSpan(
                                    text: AppStrings.signUpLink,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 18.w,
              height: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}