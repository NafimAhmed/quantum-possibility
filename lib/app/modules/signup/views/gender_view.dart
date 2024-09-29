import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../models/gender.dart';
import '../controllers/signup_controller.dart';

class GenderView extends GetView<SignupController> {
  const GenderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getGenders();
    return Scaffold(
      backgroundColor: Colors.white,
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
                'Gender',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                const Divider(height: 1),
                const SizedBox(height: 40),
                const Text(
                  'What,s your gender?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You can change who sees your gennder on your profile later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 40),
                Column(
                  children: controller.genderList.value
                      .map((element) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    element.gender_name ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Radio<GenderModel>(
                                    value: element,
                                    groupValue: controller.selectedGender.value,
                                    onChanged: (GenderModel? value) {
                                      controller.selectedGender.value = value;
                                      controller.selectedGender.refresh();
                                    },
                                  ),
                                ],
                              ),
                              const Divider()
                            ],
                          ))
                      .toList(),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            onPressed: controller.onClickNextFromGender,
                            text: 'Next'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
