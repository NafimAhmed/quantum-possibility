import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../../../components/button.dart';
import '../../../../../../../config/app_assets.dart';
import '../../../../../../../utils/color.dart';
import '../controllers/create_image_story_controller.dart';

class CreateImageStoryView extends GetView<CreateImageStoryController> {
  const CreateImageStoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.xFile = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Create Story',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                Screenshot(
                  controller: controller.screenshotController,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(controller.xFile.path)))),
                    child: Stack(
                      children: [
                        Positioned(
                          left: controller.textPosition.value.dx,
                          top: controller.textPosition.value.dy,
                          child: GestureDetector(
                            onTap: () {
                              controller.isBottomSheetVisiable.value = true;
                              Get.bottomSheet(Container(
                                decoration: const BoxDecoration(),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  focusNode: controller.storyTextFocusNode,
                                  controller: controller.storyTextController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  autofocus: true,
                                  onFieldSubmitted: (value) {
                                    // controller.isBottomSheetVisiable.value = false;
                                    // controller.storyText.value = value;
                                    // Get.back();
                                  },
                                ),
                              ));
                            },
                            onPanUpdate: (details) {
                              controller.textPosition.value = Offset(
                                controller.textPosition.value.dx +
                                    details.delta.dx,
                                controller.textPosition.value.dy +
                                    details.delta.dy,
                              );
                            },
                            child: (controller.storyText.value == '')
                                ? const SizedBox(
                                    height: 100,
                                    width: double.maxFinite,
                                    child: Text('Hello'),
                                  )
                                : Obx(() => Visibility(
                                      visible: !(controller
                                          .isBottomSheetVisiable.value),
                                      child: Text(
                                        controller.storyText.value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: Colors.white),
                        height: Get.height / 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.seletedPrivacy.value = 'Public';
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.public,
                                      color: (controller.seletedPrivacy.value ==
                                              'Public')
                                          ? PRIMARY_COLOR
                                          : null),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Public',
                                    style: TextStyle(
                                        color:
                                            (controller.seletedPrivacy.value ==
                                                    'Public')
                                                ? PRIMARY_COLOR
                                                : null),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.seletedPrivacy.value = 'Friends';
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.group,
                                      color: (controller.seletedPrivacy.value ==
                                              'Friends')
                                          ? PRIMARY_COLOR
                                          : null),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Friends',
                                    style: TextStyle(
                                        color:
                                            (controller.seletedPrivacy.value ==
                                                    'Friends')
                                                ? PRIMARY_COLOR
                                                : null),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.seletedPrivacy.value = 'Only Me';
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.lock,
                                      color: (controller.seletedPrivacy.value ==
                                              'Only Me')
                                          ? PRIMARY_COLOR
                                          : null),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Only Me',
                                    style: TextStyle(
                                        color:
                                            (controller.seletedPrivacy.value ==
                                                    'Only Me')
                                                ? PRIMARY_COLOR
                                                : null),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                    },
                    child: Visibility(
                      visible: (!controller.isBottomSheetVisiable.value),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // spreadRadius: 5,
                            blurRadius: 30,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                        child: const Column(
                          children: [
                            Image(
                              height: 24,
                              image: AssetImage(AppAssets.PRIVACY_WHITE_ICON),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Privacy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Visibility(
                    visible: (!controller.isBottomSheetVisiable.value),
                    child: PrimaryButton(
                      onPressed: () {
                        controller.shareStory();
                      },
                      text: 'Post',
                      fontSize: 14,
                      verticalPadding: 0,
                      horizontalPadding: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
