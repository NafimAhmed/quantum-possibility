import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/comment/comment_component.dart';
import '../../../components/post/post.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notification_controller.dart';

class NotificationPost extends GetView<NotificationPostController> {
  String postId = Get.arguments;

  NotificationPost({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getPosts(postId);

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Post',
            ),
            centerTitle: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Column(
            children: [
              Obx(
                () => controller.isLoadingNewsFeed.value == true
                    ? const Expanded(
                        child: Center(
                        child: CircularProgressIndicator(),
                      ))
                    : PostCard(
                        model: controller.postList.value[0],
                        onSelectReaction: (String reaction) {},
                        onPressedComment: () {
                          Get.bottomSheet(
                            Obx(
                              () => CommentComponent(
                                commentController: controller.commentController,
                                postModel: controller.postList.value[0],
                                userModel: controller.userModel,
                                onTapSendComment: () {
                                  controller.commentOnPost(
                                      controller.postList.value[0]);
                                },
                                onTapReplayComment: (
                                    {required commentReplay,
                                    required comment_id}) {},
                                onSelectCommentReaction: (reaction) {},
                                onSelectCommentReplayReaction: (reaction) {},
                                onTapViewReactions: () {
                                  Get.toNamed(Routes.REACTIONS,
                                      arguments:
                                          controller.postList.value[0].id);
                                },
                              ),
                            ),
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                          );
                        },
                        onPressedShare: () {},
                        onTapBodyViewMoreMedia: () {},
                        onTapViewReactions: () {
                          Get.toNamed(
                            Routes.REACTIONS,
                            arguments: controller.postList.value[0].id,
                          );
                        },
                      ),
              )
            ],
          ) //PostCard(model: null, onSelectReaction: (String reaction) {  }, onPressedComment: () {  }, onPressedShare: () {  }, onTapBodyViewMoreMedia: () {  }, onTapViewReactions: () {  },),
          ),
    );
  }
}
