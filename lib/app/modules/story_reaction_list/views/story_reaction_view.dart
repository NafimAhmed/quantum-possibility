import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/components/image.dart';
import 'package:quantum_possibilities_flutter/app/modules/story_reaction_list/controller/story_reaction_controller.dart';
import 'package:quantum_possibilities_flutter/app/utils/image.dart';

import '../../../config/app_assets.dart';
import '../../../utils/color.dart';
import '../../../utils/post_utlis.dart';

class StoryReactionView extends GetView<StoryReactionController> {
   StoryReactionView({super.key});

   int storyIndex=0;

  @override
  Widget build(BuildContext context) {
    controller.getStoriesView();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'People who viewed',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [



            Obx(() => controller.isLoadingStory!=true?ListView.builder(
                shrinkWrap: true,
                itemCount: controller.storytList.value.first.stories?[storyIndex].viewersList?.length,
                itemBuilder: (context, viewindex) {



                  debugPrint("=============Story index ${viewindex}=======================================");


                  return Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: RoundCornerNetworkImage(
                          imageUrl: getFormatedProfileUrl(
                              '${controller.storytList.value.first.stories?[storyIndex].viewersList?[viewindex].profilePic}'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.storytList.value.first.stories?[storyIndex].viewersList?[viewindex].firstName} ${controller.storytList.value.first.stories?[storyIndex].viewersList?[viewindex].lastName}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),



                         
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        child:


                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.storytList.value.first.stories?[storyIndex].viewersList?[viewindex].reactions?.length,
                            itemBuilder: (context,index){return Icon(Icons.add_circle);}
                        ),
                      )



                    ],
                  );
                }):Center(child: CircularProgressIndicator()))

            // DefaultTabController(
            //   length: 8,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10.0),
            //         child: TabBar(
            //           tabAlignment: TabAlignment.start,
            //           indicatorSize: TabBarIndicatorSize.label,
            //           indicator: const UnderlineTabIndicator(
            //             borderSide: BorderSide(
            //               width: 2,
            //               color: PRIMARY_COLOR,
            //             ),
            //           ),
            //           isScrollable: true,
            //           dividerColor: Colors.grey,
            //           tabs: [
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: const Row(
            //                 children: [
            //                   Text(
            //                     'All',
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //
            //                   //Text(' ${controller.reactionList.value.length}'),
            //                   Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/like_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.likeList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/love_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.loveList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/haha_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.hahaList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/wow_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.wowList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/sad_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.sadList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     'assets/icon/reaction/angry_icon.png',
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.angryList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: const EdgeInsets.only(bottom: 10),
            //               child: Row(
            //                 children: [
            //                   Image.asset(
            //                     AppAssets.UNLIKE_ICON,
            //                     height: 25,
            //                     width: 25,
            //                   ),
            //                   // Text(' ${controller.unlikeList.value.length}'),
            //                   const Text(' 0'),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       //====================================================================== Tab Bar View ======================================================================//
            //
            //       SizedBox(
            //         height: Get.height,
            //         child: const TabBarView(
            //           children: [
            //             // ==================================== All Reaction List ============================//
            //
            //             // Obx(() => controller.isReactionLoding.value == true
            //             //     ? const Center(child: CircularProgressIndicator())
            //             //     : controller.reactionList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount:
            //             //   controller.reactionList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.reactionList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // ) :
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             //),
            //
            //             // ==================================== Like Reaction List ============================//
            //
            //             // Obx(() => controller.likeList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.likeList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.likeList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             //),
            //             // ==================================== Love Reaction List ============================//
            //
            //             // Obx(() => controller.loveList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.loveList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.loveList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // ) :
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             //),
            //             // ==================================== Haha Reaction List ============================//
            //
            //             // Obx(() => controller.hahaList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.hahaList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.hahaList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             // ),
            //
            //             // ==================================== Wow Reaction List ============================//
            //
            //             // Obx(() => controller.wowList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.wowList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.wowList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //             //
            //
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             //),
            //             // ==================================== Sad Reaction List ============================//
            //
            //             // Obx(() => controller.sadList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.sadList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.sadList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             // ),
            //             // ==================================== Angry Reaction List ============================//
            //
            //             // Obx(() => controller.angryList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.angryList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.angryList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             // ),
            //             // ==================================== Unlike Reaction List ============================//
            //
            //             // Obx(() => controller.unlikeList.value.isNotEmpty
            //             //     ? ListView.builder(
            //             //   shrinkWrap: true,
            //             //   physics: const ScrollPhysics(),
            //             //   itemCount: controller.unlikeList.value.length,
            //             //   itemBuilder: (context, index) {
            //             //     ReactionModel model =
            //             //     controller.unlikeList.value[index];
            //             //     UserIdModel userIdModel = model.user_id!;
            //             //     return ReactionListTile(
            //             //       name:
            //             //       '${userIdModel.first_name} ${userIdModel.last_name}',
            //             //       profilePicUrl: getFormatedProfileUrl(
            //             //           userIdModel.profile_pic ?? ''),
            //             //       reaction: getReactionIconPath(
            //             //         model.reaction_type ?? '',
            //             //       ),
            //             //     );
            //             //   },
            //             // )
            //             //     :
            //
            //             Center(
            //               child: Text('No Reaction'),
            //             ),
            //
            //             // ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
