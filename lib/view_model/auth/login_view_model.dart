import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/repository/auth_repository.dart';
import 'package:quick_slot_app/res/field_validation/field_validation.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';
import 'package:quick_slot_app/utils/utils.dart';

class LoginViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool loading = false.obs;

  void toggleObscure() => obscurePassword.value = !obscurePassword.value;

  bool _validate() {
    emailError.value =
        AppFieldValidation.validateEmail(emailController.text.trim());
    passwordError.value =
        AppFieldValidation.validatePassword(passwordController.text);
    return emailError.value.isEmpty && passwordError.value.isEmpty;
  }

  Future<void> onLogin() async {
    if (loading.value || !_validate()) return;
    loading.value = true;
    try {
      final user = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Session.set(user.uid, user.displayName ?? 'Player');
      Get.offAllNamed(RouteName.venueList);
    } on FirebaseAuthException catch (error) {
      Utils.snack(text: AuthErrors.message(error.code));
    } catch (_) {
      Utils.snack(text: 'Something went wrong, please try again.');
    } finally {
      loading.value = false;
    }
  }

  void goToRegister() => Get.toNamed(RouteName.register);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
