import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/field_validation/field_validation.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';

class LoginViewModel extends GetxController {
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

  void onLogin() {
    if (!_validate()) return;
  }

  void goToRegister() => Get.toNamed(RouteName.register);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
