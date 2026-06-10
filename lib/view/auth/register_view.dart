import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/auth/register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel controller = Get.put(RegisterViewModel());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appbars(
        context,
        title: "Create Account",
        onPressed: controller.goToLogin,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: paddingSymmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalSpace(8.0),
              labels(
                text: "Join Quick Slot",
                fontWeight: FontWeight.w700,
                size: 22.0,
                textAlign: TextAlign.start,
              ),
              verticalSpace(6.0),
              labels(
                text: "Create an account to start booking",
                color: AppColor.grey,
                size: 14.0,
                textAlign: TextAlign.start,
              ),
              verticalSpace(28.0),
              Obx(
                () => FieldAndLabel(
                  controller: controller.nameController,
                  labelValue: "Full Name",
                  hint: "Your name",
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  fillColor: AppColor.white,
                  borderColor: AppColor.dividerColor,
                  borderSideWidth: 1.2,
                  circularRadius: 10.0,
                  labelStyle: defaultTextStyle(
                    size: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  validationMessage: controller.nameError.value,
                  onChanged: (_) {},
                ),
              ),
              verticalSpace(10.0),
              Obx(
                () => FieldAndLabel(
                  controller: controller.emailController,
                  labelValue: "Email",
                  hint: "you@example.com",
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  fillColor: AppColor.white,
                  borderColor: AppColor.dividerColor,
                  borderSideWidth: 1.2,
                  circularRadius: 10.0,
                  labelStyle: defaultTextStyle(
                    size: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  validationMessage: controller.emailError.value,
                  onChanged: (_) {},
                ),
              ),
              verticalSpace(10.0),
              Obx(
                () => FieldAndLabel(
                  controller: controller.passwordController,
                  labelValue: "Password",
                  hint: "At least 6 characters",
                  isPassword: controller.obscurePassword.value,
                  textInputAction: TextInputAction.next,
                  fillColor: AppColor.white,
                  borderColor: AppColor.dividerColor,
                  borderSideWidth: 1.2,
                  circularRadius: 10.0,
                  labelStyle: defaultTextStyle(
                    size: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  rightIcon: iconButton(
                    context,
                    icon: controller.obscurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.grey,
                    size: 22.0,
                    onPressed: controller.toggleObscure,
                  ),
                  validationMessage: controller.passwordError.value,
                  onChanged: (_) {},
                ),
              ),
              verticalSpace(10.0),
              Obx(
                () => FieldAndLabel(
                  controller: controller.confirmPasswordController,
                  labelValue: "Confirm Password",
                  hint: "Re-enter your password",
                  isPassword: controller.obscureConfirmPassword.value,
                  textInputAction: TextInputAction.done,
                  fillColor: AppColor.white,
                  borderColor: AppColor.dividerColor,
                  borderSideWidth: 1.2,
                  circularRadius: 10.0,
                  labelStyle: defaultTextStyle(
                    size: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                  rightIcon: iconButton(
                    context,
                    icon: controller.obscureConfirmPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.grey,
                    size: 22.0,
                    onPressed: controller.toggleConfirmObscure,
                  ),
                  validationMessage: controller.confirmPasswordError.value,
                  onChanged: (_) {},
                ),
              ),
              verticalSpace(30.0),
              Obx(
                () => button(
                  text: "Register",
                  width: double.infinity,
                  fontWeight: FontWeight.w600,
                  loading: controller.loading.value,
                  onTap: controller.onRegister,
                ),
              ),
              verticalSpace(16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: labels(
                      text: "Already have an account?",
                      color: AppColor.grey,
                      size: 13.0,
                    ),
                  ),
                  textButton(
                    onPressed: controller.goToLogin,
                    child: labels(
                      text: "Login",
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w700,
                      size: 13.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
