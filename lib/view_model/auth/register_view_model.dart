import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/field_validation/field_validation.dart';

class RegisterViewModel extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxString nameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool loading = false.obs;

  void toggleObscure() => obscurePassword.value = !obscurePassword.value;

  void toggleConfirmObscure() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  bool _validate() {
    nameError.value =
        AppFieldValidation.validateName(nameController.text);
    emailError.value =
        AppFieldValidation.validateEmail(emailController.text.trim());
    passwordError.value =
        AppFieldValidation.validatePassword(passwordController.text);
    confirmPasswordError.value = AppFieldValidation.validateConfirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );
    return nameError.value.isEmpty &&
        emailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty;
  }

  void onRegister() {
    if (!_validate()) return;
  }

  void goToLogin() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
