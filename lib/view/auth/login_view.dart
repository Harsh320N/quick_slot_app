import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_slot_app/res/colors/app_color.dart';
import 'package:quick_slot_app/res/widgets/widget_export.dart';
import 'package:quick_slot_app/view_model/auth/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel controller = Get.put(LoginViewModel());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: paddingSymmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalSpace(36.0),
              _header(),
              verticalSpace(40.0),
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
                  hint: "Enter your password",
                  isPassword: controller.obscurePassword.value,
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
              verticalSpace(30.0),
              Obx(
                () => button(
                  text: "Login",
                  width: double.infinity,
                  fontWeight: FontWeight.w600,
                  loading: controller.loading.value,
                  onTap: controller.onLogin,
                ),
              ),
              verticalSpace(16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: labels(
                      text: "Don't have an account?",
                      color: AppColor.grey,
                      size: 13.0,
                    ),
                  ),
                  textButton(
                    onPressed: controller.goToRegister,
                    child: labels(
                      text: "Register",
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

  Widget _header() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'assets/icon/app_icon.png',
            height: 84.0,
            width: 84.0,
          ),
        ),
        verticalSpace(20.0),
        labels(
          text: "Welcome Back",
          fontWeight: FontWeight.w700,
          size: 24.0,
        ),
        verticalSpace(6.0),
        labels(
          text: "Login to continue booking your slots",
          color: AppColor.grey,
          size: 14.0,
        ),
      ],
    );
  }
}
