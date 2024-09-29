import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class BirthdayView extends GetView<SignupController> {
  const BirthdayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Text('Birthday', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Container(
        height: Get.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(height: 1),
              const SizedBox(height: 40),
              const Text(
                'What’s your birthday?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'We’ll help you\ncreate a new account in a few easy steps.',
                style: TextStyle(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(40),
                child: DatePickerWidget(
                  looping: true, // default is not looping
                  firstDate: DateTime(1950, 01, 01),
                  lastDate: DateTime.now().subtract(const Duration(days: 4750)),
                  initialDate: DateTime(2000, 01, 01),
                  dateFormat: 'dd-MMM-yyyy',
                  locale: DatePicker.localeFromString('en'),
                  onChange: (DateTime newDate, context) {
                    controller.onSelectDate(newDate);
                  },
                  pickerTheme: const DateTimePickerTheme(
                    itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                    dividerColor: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => Text(
                  '${controller.year.value.toStringAsFixed(0)} years old',
                  style: const TextStyle(color: Colors.black),
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
                            Get.toNamed(Routes.GENDER);
                          },
                          text: 'Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
