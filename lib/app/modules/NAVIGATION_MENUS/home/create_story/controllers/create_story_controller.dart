import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../../routes/app_pages.dart';

class CreateStoryController extends GetxController {
  Rx<List<AssetPathEntity>> albumList = Rx([]);

  void onTapCreateTextStory() {
    Get.toNamed(
      Routes.CREATE_TEXT_STORY,
    );
  }

  void onTapPickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      Get.toNamed(Routes.CREATE_IMAGE_STORY, arguments: xFile);
    }
  }

  Future<List<AssetPathEntity>> getAllImageAlbum() async {
    var permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth == true) {
      albumList.value =
          await PhotoManager.getAssetPathList(type: RequestType.image);
    } else {
      PhotoManager.openSetting();
    }
    return albumList.value;
  }

  @override
  void onInit() {
    // getAllImageAlbum();
    super.onInit();
  }
}
