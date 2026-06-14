import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  var currentUser = Rx<UserModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var nameError = ''.obs;

  var passwordStrength = 0.obs;
  var passwordStrengthLabel = ''.obs;

  bool _isSigningUp = false;

  @override
  void onInit() {
    super.onInit();
    AuthService.authStateChanges.listen((firebaseUser) {
      if (firebaseUser != null) {
        currentUser.value = UserModel.fromFirebase(firebaseUser);
        if (!_isSigningUp) {
          final route = Get.currentRoute;
          if (route == AppRoutes.login || route == AppRoutes.signup) {
            Get.offAllNamed(AppRoutes.home);
          }
        }
      } else {
        currentUser.value = null;
      }
    });
  }

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = 0;
      passwordStrengthLabel.value = '';
      return;
    }

    int score = 0;

    if (password.length >= 6) score++;
    if (password.length >= 10) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

    if (score <= 1) {
      passwordStrength.value = 1;
      passwordStrengthLabel.value = 'Weak';
    } else if (score == 2) {
      passwordStrength.value = 2;
      passwordStrengthLabel.value = 'Fair';
    } else if (score == 3) {
      passwordStrength.value = 3;
      passwordStrengthLabel.value = 'Good';
    } else {
      passwordStrength.value = 4;
      passwordStrengthLabel.value = 'Strong ✓';
    }
  }

  bool _validateName(String name) {
    nameError.value = '';
    if (name.trim().isEmpty) {
      nameError.value = 'Name cannot be empty';
      return false;
    }
    if (name.trim().length < 3) {
      nameError.value = 'Name must be at least 3 characters';
      return false;
    }
    return true;
  }

  bool _validateEmail(String email) {
    emailError.value = '';
    if (email.trim().isEmpty) {
      emailError.value = 'Email cannot be empty';
      return false;
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email.trim())) {
      emailError.value = 'Enter a valid email — example@gmail.com';
      return false;
    }
    return true;
  }

  bool _validatePassword(String password, {bool checkStrength = true}) {
    passwordError.value = '';
    if (password.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      return false;
    }
    if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }
    if (checkStrength && passwordStrength.value < 2) {
      passwordError.value = 'Password is too weak — add numbers or uppercase';
      return false;
    }
    return true;
  }

  Future<void> signUp(String name, String email, String password) async {
    final isNameValid = _validateName(name);
    final isEmailValid = _validateEmail(email);
    final isPasswordValid = _validatePassword(password);
    if (!isNameValid || !isEmailValid || !isPasswordValid) return;

    try {
      _isSigningUp = true;
      isLoading.value = true;
      errorMessage.value = '';

      await AuthService.signUp(email.trim(), password.trim(), name.trim());
      await AuthService.logout();
      _isSigningUp = false;

      Get.snackbar(
        'Success',
        'Account created! Please login to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      Get.offAllNamed(AppRoutes.login);

    } on FirebaseAuthException catch (e) {
      _isSigningUp = false;
      errorMessage.value = _getFirebaseError(e.code);
    } catch (e) {
      _isSigningUp = false;
      errorMessage.value = 'Something went wrong. Try again';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    final isEmailValid = _validateEmail(email);
    final isPasswordValid = _validatePassword(password, checkStrength: false);
    if (!isEmailValid || !isPasswordValid) return;

    try {
      _isSigningUp = false;
      isLoading.value = true;
      errorMessage.value = '';
      await AuthService.login(email.trim(), password.trim());
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getFirebaseError(e.code);
    } catch (e) {
      errorMessage.value = 'Something went wrong. Try again';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isSigningUp = false;
      isLoading.value = true;
      errorMessage.value = '';
      await AuthService.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _getFirebaseError(e.code);
    } catch (e) {
      errorMessage.value = e.toString().contains('cancel')
          ? 'Google Sign In cancelled'
          : 'Something went wrong. Try again';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
  }

  void clearErrors() {
    errorMessage.value = '';
    emailError.value = '';
    passwordError.value = '';
    nameError.value = '';
  }

  void resetPasswordStrength() {
    passwordStrength.value = 0;
    passwordStrengthLabel.value = '';
  }

  String _getFirebaseError(String code) {
    switch (code) {
      case 'invalid-credential':
        return 'Email or password is incorrect';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'Invalid email format';
      case 'weak-password':
        return 'Password is too weak';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'network-request-failed':
        return 'Check your internet connection';
      default:
        return 'Something went wrong ($code)';
    }
  }
}