import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/shared/create_post/controller/create_post_controller.dart';
import '../utils/color.dart';
import 'button.dart';

class EventSubTypeBody extends StatelessWidget {
  const EventSubTypeBody(
      {super.key,
      required this.imageLink,
      required this.title,
      required this.onPressed,
      required this.controller});
  final String imageLink;
  final String title;
  final VoidCallback onPressed;
  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('org name ............${controller.startDate}');
    debugPrint('org name ............${controller.endDate}');

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageLink,
              width: 100,
              height: 100,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                initialValue: title,
                readOnly: true,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'position'),
                onChanged: (value) {
                  controller.designation.value = value.toString();
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'work place'),
                onChanged: (value) {
                  controller.orgName.value = value.toString();
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Visibility(
            visible:
                title == 'Left Job' || title == 'Retirement' ? false : true,
            child: Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950, 1, 1),
                    lastDate: DateTime(2050, 1, 1),
                  ).then((value) {
                    if (value != null) {
                      controller.startDate.value =
                          '${value.year}-${value.month}-${value.day}';
                    }
                  });
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        controller.startDate.value == null
                            ? 'start date'
                            : controller.startDate.value.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: "join date"
              //     ),
              //     onChanged: (value){
              //       controller.startDate.value = value.toString();
              //     },
              //   ),
              // ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950, 1, 1),
                lastDate: DateTime(2050, 1, 1),
              ).then((value) {
                if (value != null) {
                  controller.endDate.value =
                      '${value.year}-${value.month}-${value.day}';
                }
              });
            },
            child: Visibility(
              visible:
                  title == 'New Job' || title == 'Promotion' ? false : true,
              child: Container(
                height: 50,
                width: double.maxFinite,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        controller.endDate.value == null
                            ? 'end date'
                            : controller.endDate.value.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: title == 'New Job' ? true : false,
          child: Row(
            children: [
              Obx(
                () => Checkbox(
                  checkColor: Colors.white,
                  activeColor: PRIMARY_COLOR,
                  value: controller.is_current_working.value,
                  onChanged: (bool? value) {
                    controller.is_current_working.value = value!;
                  },
                ),
              ),
              SizedBox(
                width: Get.width - 50,
                child: const Text(
                  'Currenly Working',
                  style: TextStyle(fontSize: 15),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        PrimaryButton(
          onPressed: onPressed,
          text: 'create',
          horizontalPadding: 150,
          verticalPadding: 12,
        )
      ],
    );
  }
}
