import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/data/session/session.dart';
import 'package:quick_slot_app/repository/auth_repository.dart';
import 'package:quick_slot_app/res/field_validation/field_validation.dart';
import 'package:quick_slot_app/res/routes/route_name.dart';
import 'package:quick_slot_app/utils/utils.dart';

class RegisterViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

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
    nameError.value = AppFieldValidation.validateName(nameController.text);
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

  Future<void> onRegister() async {
    if (loading.value || !_validate()) return;
    loading.value = true;
    try {
      final user = await _authRepository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Session.set(user.uid, user.displayName ?? nameController.text.trim());
      Get.offAllNamed(RouteName.venueList);
    } on FirebaseAuthException catch (error) {
      Utils.snack(text: AuthErrors.message(error.code));
    } catch (_) {
      Utils.snack(text: 'Something went wrong, please try again.');
    } finally {
      loading.value = false;
    }
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
