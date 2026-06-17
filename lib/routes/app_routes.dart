import 'package:get/get.dart';
import 'package:med_reminder_app/features/medicine/views/medicine_detail_view.dart';
import 'package:med_reminder_app/features/splash/splash_screen.dart';

import '../features/auth/views/login_view.dart';
import '../features/auth/views/signup_view.dart';
import '../features/medicine/views/main_view.dart';

class AppRoutes {
  AppRoutes._();
  static const String login = '/login';
  static const String signup = '/signup';
  static const String splash = '/splash';
  static const String home = '/home';


  static final pages = [
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: signup, page: () => SignupView()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home,    page: () => MainView()),
  ];
}