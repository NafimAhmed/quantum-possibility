import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../../../data/story.dart';
import '../../../../../../../models/api_response.dart';
import '../../../../../../../services/api_communication.dart';
import '../../../../controllers/home_controller.dart';

class CreateImageStoryController extends GetxController {
  late XFile xFile;
  late ApiCommunication _apiCommunication;
  final ScreenshotController screenshotController = ScreenshotController();
  //Text moving
  Rx<Offset> textPosition =
      Offset((Get.width / 2) - 25, (Get.height / 2 - 25)).obs;
  late final TextEditingController storyTextController;
  late final FocusNode storyTextFocusNode;
  Rx<String> storyText = ''.obs;
  Rx<bool> isBottomSheetVisiable = false.obs;

  Rx<Color> seletedBackgroundColor = storyListColor[0].obs;
  Rx<String> seletedPrivacy = 'Public'.obs;

  Future<void> shareStory() async {
    Uint8List? screenshotData = await screenshotController.capture();
    if (screenshotData != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(screenshotData);
      shareImage(imagePath);
    }
  }

  Future<void> shareImage(File file) async {
    final ApiResponse response = await _apiCommunication.doPostRequest(
      enableLoading: true,
      apiEndPoint: 'save-story',
      isFormData: true,
      requestData: {
        'title': 'fao',
        'privacy': 'public',
      },
      mediaFiles: [file],
    );

    if (response.isSuccessful) {
      HomeController controller = Get.find();
      controller.getStories();
      Get.back();
      Get.back();
    }
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    storyTextController = TextEditingController();
    storyTextFocusNode = FocusNode();
    storyTextFocusNode.addListener(() {
      if (storyTextFocusNode.hasFocus) {
        debugPrint('Input field has focus!');
        // Perform actions when the input field gains focus
      } else {
        debugPrint('Input field lost focus.');
        // Get.back();
        isBottomSheetVisiable.value = false;
        storyText.value = storyTextController.text;
        Get.back();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    storyTextController.dispose();
    super.onClose();
  }
}
