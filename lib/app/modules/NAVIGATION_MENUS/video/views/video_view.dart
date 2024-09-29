import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/reels_component.dart';
import '../controllers/video_controller.dart';
import '../model/reels_model.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();

    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() => controller.isLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.reelsModelList.value.length,
                itemBuilder: (context, index) {
                  bool myLike = false;
                  ReelsModel reelsModel =
                      controller.reelsModelList.value[index];

                  for (ReelsReactionModel reels_model
                      in reelsModel.reactions ?? []) {
                    if (reels_model.user_id ==
                        controller.loginCredential.getUserData().id) {
                      myLike = true;
                    }
                  }
                  return ReelsComponent(
                    isLiked: myLike,
                    carouselController: carouselController,
                    // controller: controller.videoPlayController,
                    reelsModel: reelsModel,
                    onPressedLike: () {
                      controller.reelsLike(reelsModel.id ?? '', index);
                    },
                    onPressedComment: (value) {
                      controller.reelsComments(
                          reelsModel.id ?? '', value, index);
                    },
                  );
                },
              )));
  }
}
