import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/text_form_field.dart';
import '../../../config/app_assets.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Image(
                    height: 128,
                    image: AssetImage(AppAssets.APP_LOGO),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome to the first decentralised\n Social Network in the world',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SfProDisplay',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login here',
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SfProDisplay',
                    ),
                  ),
                  const SizedBox(height: 40),
                  LoginTextFormField(
                    controller: controller.userIdController,
                    obscureText: false,
                    label: 'Email',
                    validationText: 'Email is required',
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => LoginTextFormField(
                      controller: controller.passwordController,
                      label: 'Password',
                      obscureText: controller.obscureText.value,
                      suffixIconButton: IconButton(
                        onPressed: () {
                          controller.obscureText.value =
                              !controller.obscureText.value;
                        },
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      validationText: 'Password is required',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        onPressed: () {},
                        text: 'Forgot your password?',
                        backgroundColor: Colors.transparent,
                        textColor: PRIMARY_COLOR,
                        horizontalPadding: 0,
                        fontSize: 16,
                        verticalPadding: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            onPressed: () {
                              debugPrint('function call before ');
                              controller.onPressedLogin();
                            },
                            text: 'Sign in'),
                      ),
                    ],
                  ),
                  PrimaryButton(
                    onPressed: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    text: 'Create new account',
                    backgroundColor: Colors.transparent,
                    textColor: Colors.grey.shade800,
                    fontSize: 18,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
