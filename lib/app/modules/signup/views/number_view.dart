import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class NumberView extends GetView<SignupController> {
  const NumberView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
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
                'Mobile Number',
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
              const Divider(
                height: 1,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              const Text(
                'Enter your Mobile Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Center(
                child: Text(
                  'Enter the Mobile Number where you can be reached.\nNo one else will see this on your profile',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Form(
                key: controller.mobileFormKey,
                child: SignUpTextFormField(
                  controller: controller.mobileController,
                  label: 'Mobile number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile number is required';
                    }
                    //  else if (value.length != 14) {
                    //   return 'Mobile number must me 11 character';
                    // }
                    else {
                      return null;
                    }
                  },
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
                            if (controller.mobileFormKey.currentState!
                                .validate()) {
                              Get.toNamed(Routes.PASSWORD);
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
