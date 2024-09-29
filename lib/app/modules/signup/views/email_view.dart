import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class EmailView extends GetView<SignupController> {
  const EmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            const Center(
              child: Text(
                'Email address',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: Get.height,
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(height: 1),
              const SizedBox(height: 40),
              const Text(
                'Enter your Email address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  'Enter the email address where you can be reached.\nNo one else will see this on your profile',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Form(
                key: controller.emailFormKey,
                child: SignUpTextFormField(
                  controller: controller.emailController,
                  label: 'Email address',
                  validationText: 'Email address is required.',
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          onPressed: () {
                            if (controller.emailFormKey.currentState!
                                .validate()) {
                              Get.toNamed(Routes.NUMBER);
                            }
                          },
                          text: 'Next'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
