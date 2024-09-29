import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/app_assets.dart';

import '../../../../components/reaction_list_tile.dart';
import '../../../../models/reaction_model.dart';
import '../../../../models/user_id.dart';
import '../../../../utils/color.dart';
import '../../../../utils/image.dart';
import '../../../../utils/post_utlis.dart';
import '../controllers/reactions_controller.dart';

class ReactionsView extends GetView<ReactionsController> {
  const ReactionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'People who reacted',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          children: [
            DefaultTabController(
              length: 8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      isScrollable: true,
                      dividerColor: Colors.grey,
                      tabs: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              const Text(
                                'All',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(' ${controller.reactionList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/like_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.likeList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/love_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.loveList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/haha_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.hahaList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/wow_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.wowList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/sad_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.sadList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/reaction/angry_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.angryList.value.length}'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                AppAssets.UNLIKE_ICON,
                                height: 25,
                                width: 25,
                              ),
                              Text(' ${controller.unlikeList.value.length}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //====================================================================== Tab Bar View ======================================================================//

                  SizedBox(
                    height: Get.height,
                    child: TabBarView(
                      children: [
                        // ==================================== All Reaction List ============================//

                        Obx(() => controller.isReactionLoding.value == true
                            ? const Center(child: CircularProgressIndicator())
                            : controller.reactionList.value.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount:
                                        controller.reactionList.value.length,
                                    itemBuilder: (context, index) {
                                      ReactionModel model =
                                          controller.reactionList.value[index];
                                      UserIdModel userIdModel = model.user_id!;
                                      return ReactionListTile(
                                        name:
                                            '${userIdModel.first_name} ${userIdModel.last_name}',
                                        profilePicUrl: getFormatedProfileUrl(
                                            userIdModel.profile_pic ?? ''),
                                        reaction: getReactionIconPath(
                                          model.reaction_type ?? '',
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text('No Reaction'),
                                  )),
                        // ==================================== Like Reaction List ============================//

                        Obx(() => controller.likeList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.likeList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.likeList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                        // ==================================== Love Reaction List ============================//

                        Obx(() => controller.loveList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.loveList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.loveList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                        // ==================================== Haha Reaction List ============================//

                        Obx(() => controller.hahaList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.hahaList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.hahaList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),

                        // ==================================== Wow Reaction List ============================//

                        Obx(() => controller.wowList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.wowList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.wowList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                        // ==================================== Sad Reaction List ============================//

                        Obx(() => controller.sadList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.sadList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.sadList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                        // ==================================== Angry Reaction List ============================//

                        Obx(() => controller.angryList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.angryList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.angryList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                        // ==================================== Unlike Reaction List ============================//

                        Obx(() => controller.unlikeList.value.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.unlikeList.value.length,
                                itemBuilder: (context, index) {
                                  ReactionModel model =
                                      controller.unlikeList.value[index];
                                  UserIdModel userIdModel = model.user_id!;
                                  return ReactionListTile(
                                    name:
                                        '${userIdModel.first_name} ${userIdModel.last_name}',
                                    profilePicUrl: getFormatedProfileUrl(
                                        userIdModel.profile_pic ?? ''),
                                    reaction: getReactionIconPath(
                                      model.reaction_type ?? '',
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text('No Reaction'),
                              )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //SizedBox(height: 20,),
          ],
        ),
      )),
    );
  }
}
