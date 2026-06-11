import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/constants/app_colors.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MedRemind',
          theme: ThemeData(
            fontFamily: 'PlusJakartaSans',
            scaffoldBackgroundColor: AppColors.surface,
            useMaterial3: true,
          ),
          initialBinding: BindingsBuilder(() {
            Get.put(AuthController());
          }),
          getPages: AppRoutes.pages,
          initialRoute: FirebaseAuth.instance.currentUser != null
              ? AppRoutes.splash
              : AppRoutes.login,
        );
      },
    );
  }
}