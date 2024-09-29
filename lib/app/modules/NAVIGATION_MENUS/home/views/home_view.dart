import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../components/button.dart';
import '../../../../components/simmar_loader.dart';
import '../../../../config/app_assets.dart';
import '../../../shared/multiple_image/views/multiple_image_view.dart';
import '../../../../routes/app_pages.dart';
import '../../../../components/comment/comment_component.dart';
import '../../../../components/add_story_widget.dart';
import '../../../../components/image.dart';
import '../../../../components/post/post.dart';
import '../../../../components/story.dart';
import '../../../../models/post.dart';
import '../../../../models/story.dart';
import '../../../../utils/image.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.pageNo = 1;
          controller.totalPageCount = 0;
          controller.postList.value.clear();
          controller.getPosts();
          controller.getStories();
        },
        child: SingleChildScrollView(
          controller: controller.postScrollController,
          child: Column(
            children: [
              //================================================== Do Post Section ==================================================//
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundCornerNetworkImage(
                    imageUrl: getFormatedProfileUrl(
                        controller.userModel.profile_pic ?? ''),
                  ),
                  InkWell(
                    onTap: controller.onTapCreatePost,
                    child: Container(
                      height: 40,
                      width: Get.width - 140,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        maxLines: 1,
                        "What's on your mind, ${controller.userModel.first_name}?",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.photo_library_outlined)),
                  )
                ],
              ),

              // ================================================================= Stories Section=================================================================//
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                width: Get.width,
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 150,
                      child: AddStoryWidget(
                        userModel: controller.userModel,
                        onTapCreateStory: controller.onTapCreateStory,
                      ),
                    ),
                    Obx(() =>
                        controller.isLoadingStory.value == true ?
                        Expanded(
                          child: SizedBox(
                            height: 150,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:  const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                      height: 150,
                                      child: Stack(
                                        children: [
                                          ShimmerLoader(
                                            child: Container(
                                              height: 116.48,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                border: Border.all(color: Colors.white, width: 0),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              width: 80.64,
                                            ),
                                          ),
                                          const Positioned(
                                            left: 25,
                                            top: 95,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Color.fromARGB(255, 45, 185, 185),
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundImage: AssetImage(
                                                    'assets/image/default_profile_image.png'
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ) :
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.storytList.value.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                StoryModel storyModel =
                                    controller.storytList.value[index];
                                return MyDayCard(
                                  storyModel: storyModel, storyIndex: index,
                                );
                              }),
                        )
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.grey.shade400,
              ),

              // ================================================================= Post =================================================================//

              Obx(
                () => controller.isLoadingNewsFeed.value == true ?

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  ShimmerLoader(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CircleAvatar(
                                        radius: 19,
                                        backgroundColor: Color.fromARGB(255, 45, 185, 185),
                                        child: CircleAvatar(
                                          radius: 17,
                                          backgroundImage: AssetImage(
                                              'assets/image/default_profile_image.png'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ShimmerLoader(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    border: Border.all(color: Colors.white, width: 0),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  width: Get.width - 100,
                                                ),
                                                const SizedBox(height: 7),
                                                Container(
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    border: Border.all(color: Colors.white, width: 0),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  width: Get.width / 2,
                                                ),

                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ShimmerLoader(
                              child: Container(
                                width: double.maxFinite,
                                height: 256,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ShimmerLoader(
                                  child: PostActionButton(
                                    assetName: AppAssets.LIKE_ICON,
                                    text: 'Like',
                                    onPressed: (){

                                    },
                                  ),
                                ),
                                ShimmerLoader(
                                  child: PostActionButton(
                                    assetName: AppAssets.COMMENT_ACTION_ICON,
                                    text: 'Comment',
                                    onPressed: (){

                                    },
                                  ),
                                ),
                                ShimmerLoader(
                                  child: PostActionButton(
                                    assetName: AppAssets.SHARE_ACTION_ICON,
                                    text: 'Share',
                                    onPressed: (){

                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },

                    )

                    :


                    ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.postList.value.length,
                  itemBuilder: (context, index) {
                    PostModel postModel = controller.postList.value[index];

                    debugPrint('=====Pagination index=======$index===========');

                    return PostCard(
                      model: postModel,
                      onSelectReaction: (reaction) {
                        controller.reactOnPost(
                          postModel: postModel,
                          reaction: reaction,
                          index: index,
                        );
                        debugPrint(reaction);
                      },
                      onPressedComment: () {
                        Get.bottomSheet(
                          Obx(
                            () => CommentComponent(
                              commentController: controller.commentController,
                              postModel: controller.postList.value[index],
                              userModel: controller.userModel,
                              onTapSendComment: () {
                                controller.commentOnPost(index, postModel);
                              },
                              onSelectCommentReaction: (reaction) {

                                //controller.commentReaction(reaction, post_id, comment_id)

                              },
                              onSelectCommentReplayReaction: (reaction) {


                              },
                              onTapViewReactions: () {
                                Get.toNamed(Routes.REACTIONS,
                                    arguments: postModel.id);
                              },
                              onTapReplayComment: (
                                  {required commentReplay, required comment_id}) {
                                controller.commentReply(
                                    comment_id: comment_id,
                                    replies_comment_name: commentReplay,
                                    post_id: postModel.id ?? '',
                                    postIndex: index);
                              },
                            ),
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                        );
                      },
                      onPressedShare: () {
                        // Share.share(
                        //     'https://quantumpossibilities.eu/notification/${postModel.id ?? ''}',
                        //     subject: 'Look at this');


                      },
                      onTapBodyViewMoreMedia: () {
                        Get.to(MultipleImageView(postModel: postModel));
                      },
                      onTapViewReactions: () {
                        Get.toNamed(Routes.REACTIONS, arguments: postModel.id);
                      },
                      onTapEditPost: (){
                        Get.back();
                        controller!.onTapEditPost(postModel);
                      }
                    );
                  },
                ),
              ),

              // Obx(() => Visibility(
              //       visible: controller.isLoadingNewsFeed.value,
              //       child: const CircularProgressIndicator(),
              //     )),
              // const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
