import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class NameView extends GetView<SignupController> {
  const NameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            const Text(
              'Create account',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              "What's your name?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter the name you use in real life.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: controller.nameFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: SignUpTextFormField(
                      controller: controller.firstNameController,
                      label: 'First Name',
                      validationText: 'First name is required',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SignUpTextFormField(
                      controller: controller.lastNameController,
                      label: 'Last Name',
                      validationText: 'First name is required',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      if (controller.nameFormKey.currentState!.validate()) {
                        Get.toNamed(Routes.BIRTHDAY);
                      }
                    },
                    text: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
