import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/data/login_creadential.dart';
import 'package:quantum_possibilities_flutter/app/models/comment_reaction_model.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
import 'package:quantum_possibilities_flutter/app/utils/post_utlis.dart';

import '../../config/api_constant.dart';
import '../../config/app_assets.dart';
import '../../models/comment_model.dart';
import '../../models/comment_reply_reaction.dart';
import '../../models/post.dart';
import '../../models/user_id.dart';
import '../../routes/app_pages.dart';
import '../../utils/color.dart';
import '../../utils/image.dart';
import '../image.dart';
import '../reaction_list_tile.dart';

class CommentTile extends StatelessWidget {
  final int index;
  final CommentModel commentModel;
  final FocusNode inputNodes;
  final TextEditingController textEditingController;
  final Function(String reaction) onSelectCommentReaction;
  final Function(String reaction) onSelectCommentReplayReaction;

  HomeController controller = Get.put(HomeController());

  CommentTile({
    super.key,
    required this.commentModel,
    required this.inputNodes,
    required this.textEditingController,
    required this.onSelectCommentReaction,
    required this.onSelectCommentReplayReaction,
    required this.index,
  });
  Widget PostReactionIcons(PostModel postModel) {
    Set<Image> postReactionIcons = {};
    if (postModel.reactionTypeCountsByPost != null) {
      for (ReactionModel reactionModel in postModel.reactionTypeCountsByPost!) {
        if (reactionModel.reaction_type == '') {}
        switch (reactionModel.reaction_type) {
          case 'like':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
          case 'love':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
            break;
          case 'haha':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
            break;
          case 'wow':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
            break;
          case 'sad':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
            break;
          case 'angry':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.ANGRY_ICON)));
            break;
          case 'unlike':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.UNLIKE_ICON)));
            break;
          default:
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
        }
      }
    }

    return Row(children: postReactionIcons.toList());
  }

  @override
  Widget build(BuildContext context) {
    UserIdModel? userIdModel =
        commentModel.user_id; // User who did this comment
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          //============================================================== Main Comment Section ==============================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========================================Profile Picture
              const SizedBox(width: 10),
              RoundCornerNetworkImage(
                imageUrl: getFormatedProfileUrl(
                  userIdModel?.profile_pic ?? '',
                ),
              ),
              const SizedBox(width: 10),
              // ======================================== Comment with user Name + Action Section
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [



                          InkWell(
                            onTap: (){

                              if(userIdModel?.username==LoginCredential().getUserData().username)
                                {
                                  Get.toNamed(Routes.PROFILE);
                                }
                              else{
                                Get.toNamed(Routes.OTHERS_PROFILE, arguments: userIdModel?.username);
                             }


                            },
                            child: Text(
                              '${userIdModel?.first_name} ${userIdModel?.last_name}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),




                          const SizedBox(height: 4),
                          commentModel.comment_name != null
                              ? Text(
                                  commentModel.comment_name ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                          commentModel.image_or_video != null
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      height: 100,
                                      width: 100,
                                      // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                      placeholder: const AssetImage(
                                          'assets/image/default_image.png'),
                                      image: NetworkImage(
                                          '${ApiConstant.SERVER_IP_PORT}/${commentModel.image_or_video}'),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ),

                    // ========================================= Main comments Action Section =========================================

                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width / 4,
                            child: Text(
                              maxLines: 1,
                              getDynamicFormatedCommentTime(
                                  '${commentModel.createdAt}'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ReactionButton<String>(
                            itemSize: const Size(32, 32),
                            onReactionChanged: (Reaction<String>? reaction) {
                              onSelectCommentReaction(reaction?.value ?? '');
                            },
                            placeholder: const Reaction<String>(
                              value: 'like',
                              icon: Row(
                                children: [
                                  Text(
                                    'Like',
                                  )
                                ],
                              ),
                            ),
                            reactions: <Reaction<String>>[
                              Reaction<String>(
                                value: 'like',
                                icon: ReactionIcon(AppAssets.LIKE_ICON),
                              ),
                              Reaction<String>(
                                value: 'love',
                                icon: ReactionIcon(AppAssets.LOVE_ICON),
                              ),
                              Reaction<String>(
                                value: 'haha',
                                icon: ReactionIcon(AppAssets.HAHA_ICON),
                              ),
                              Reaction<String>(
                                value: 'wow',
                                icon: ReactionIcon(AppAssets.WOW_ICON),
                              ),
                              Reaction<String>(
                                value: 'sad',
                                icon: ReactionIcon(AppAssets.SAD_ICON),
                              ),
                              Reaction<String>(
                                value: 'angry',
                                icon: ReactionIcon(AppAssets.ANGRY_ICON),
                              ),
                              Reaction<String>(
                                value: 'unlike',
                                icon: ReactionIcon(AppAssets.UNLIKE_ICON),
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              controller.commentsID.value =
                                  '${commentModel.id}';
                              controller.postID.value =
                                  '${commentModel.post_id}';

                              FocusScope.of(context).requestFocus(inputNodes);

                              controller.isReply.value = true;
                            },
                            child: const Text('Reply'),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              controller.getCommentReactions(
                                  '${commentModel.post_id}',
                                  '${commentModel.id}');
/////////////////////////////////////Comment Reaction///////////////////////////////////////////////

                              Get.bottomSheet(
                                SizedBox(
                                  width: Get.width,
                                  height: Get.height - 300,
                                  child: Column(
                                    children: [
                                      /////////////////////////////////////////////////////////

                                      DefaultTabController(
                                        length: 8,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: TabBar(
                                                tabAlignment:
                                                    TabAlignment.start,
                                                indicatorSize:
                                                    TabBarIndicatorSize.label,
                                                indicator:
                                                    const UnderlineTabIndicator(
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: PRIMARY_COLOR,
                                                  ),
                                                ),
                                                isScrollable: true,
                                                dividerColor: Colors.grey,
                                                tabs: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'All',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.reactionList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/like_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.likeList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/love_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.loveList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/haha_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.hahaList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/wow_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.wowList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/sad_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.sadList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icon/reaction/angry_icon.png',
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.angryList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          AppAssets.UNLIKE_ICON,
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        Obx(() => Text(
                                                            ' ${controller.unlikeList.value.length}')),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //====================================================================== Tab Bar View ======================================================================//

                                            SizedBox(
                                              height: Get.height - 360,
                                              child: Obx(
                                                () => controller
                                                            .isCommentReactionLoading
                                                            .value ==
                                                        true
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : TabBarView(
                                                        children: [
                                                          // ==================================== All Reaction List ============================//

                                                          Obx(() => controller
                                                                  .reactionList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .reactionList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .reactionList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                              model.reactionType),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          // ==================================== Like Reaction List ============================//

                                                          Obx(() => controller
                                                                  .likeList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .likeList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .likeList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          //Text('Like'),

                                                          // ==================================== Love Reaction List ============================//

                                                          Obx(() => controller
                                                                  .loveList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .loveList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .loveList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          //Text('Love'),
                                                          // ==================================== Haha Reaction List ============================//

                                                          Obx(() => controller
                                                                  .hahaList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .hahaList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .hahaList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          //Text('Haha'),

                                                          // ==================================== Wow Reaction List ============================//

                                                          Obx(() => controller
                                                                  .wowList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .wowList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .wowList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          // Text('data'),
                                                          // ==================================== Sad Reaction List ============================//

                                                          Obx(() => controller
                                                                  .sadList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .sadList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .sadList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          //Text("Sad"),

                                                          // ==================================== Angry Reaction List ============================//

                                                          Obx(() => controller
                                                                  .angryList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .angryList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .angryList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                )),

                                                          //Text("Sad"),

                                                          // ==================================== Unlike Reaction List ============================//

                                                          //Text('Unlike')

                                                          Obx(() => controller
                                                                  .unlikeList
                                                                  .value
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const ScrollPhysics(),
                                                                  itemCount:
                                                                      controller
                                                                          .unlikeList
                                                                          .value
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    CommentReactions
                                                                        model =
                                                                        controller
                                                                            .unlikeList
                                                                            .value[index];
                                                                    UserId
                                                                        userIdModel =
                                                                        model
                                                                            .userId;
                                                                    return ReactionListTile(
                                                                      name:
                                                                          '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                      profilePicUrl:
                                                                          getFormatedProfileUrl(userIdModel.profilePic ??
                                                                              ''),
                                                                      reaction:
                                                                          getReactionIconPath(
                                                                        model.reactionType ??
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : const Center(
                                                                  child: Text(
                                                                      'No Reaction'),
                                                                ))
                                                        ],
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      ///////////////////////////////////////////////
                                    ],
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                              );

                              ////////////////////////////////////////////////////////////////////////////
                            },
                            child: CommentReactionIcons(commentModel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //======================================== More Action Icon

              LoginCredential().getUserData().id == commentModel.user_id?.id
                  ? PopupMenuButton(
                      color: Colors.white,
                      offset: const Offset(-50, 00),
                      iconColor: Colors.grey,
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () {
                                controller.commentDelete('${commentModel.id}',
                                    '${commentModel.post_id}');
                              },
                              value: 1,
                              // row has two child icon and text.
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            // const PopupMenuItem(
                            //   value: 1,
                            //   // row has two child icon and text.
                            //   child: Text(
                            //     'Report',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                          ])
                  : const SizedBox(
                      height: 0,
                      width: 50,
                    ),

              // InkWell(
              //
              //   onTap: (){
              //
              //
              //
              //
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.all(10),
              //     child: CircleAvatar(
              //       radius: 16,
              //       child: Icon(Icons.more_horiz),
              //     ),
              //   ),
              // ),
            ],
          ),

          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          Container(
            margin: const EdgeInsets.only(left: 65),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: commentModel.replies?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RoundCornerNetworkImage(
                          imageUrl: getFormatedProfileUrl(
                            commentModel.replies?[index].replies_user_id
                                    ?.profile_pic ??
                                '',
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width / 1.9,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 221, 221, 221),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width / 1.9,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: Text(
                                            '${commentModel.replies?[index].replies_user_id?.first_name} ${commentModel.replies![index].replies_user_id?.last_name}',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      '${commentModel.replies![index].replies_comment_name}'),
                                  const SizedBox(height: 10),
                                  commentModel.replies?[index].image_or_video !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage(
                                            // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                            placeholder: const AssetImage(
                                                'assets/image/default_image.png'),
                                            image: NetworkImage(
                                                '${ApiConstant.SERVER_IP_PORT}/${commentModel.replies?[index].image_or_video}'),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width / 6,
                                  child: Text(
                                    maxLines: 1,
                                    getDynamicFormatedCommentTime(
                                        '${commentModel.replies![index].createdAt}'),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 10),
                                  child: ReactionButton<String>(
                                    itemSize: const Size(32, 32),
                                    onReactionChanged:
                                        (Reaction<String>? reaction) {
                                      debugPrint(
                                          '===============Reply Reaction==================');

                                      controller.commentReplyReaction(
                                          reaction?.value ?? '',
                                          '${commentModel.id}',
                                          '${LoginCredential().getUserData().id}',
                                          '${commentModel.post_id}',
                                          '${commentModel.replies?[index].id}');
                                    },
                                    placeholder: const Reaction<String>(
                                      value: 'like',
                                      icon: Row(
                                        children: [
                                          Text(
                                            'Like',
                                          )
                                        ],
                                      ),
                                    ),
                                    reactions: <Reaction<String>>[
                                      Reaction<String>(
                                        value: 'like',
                                        icon: ReactionIcon(AppAssets.LIKE_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'love',
                                        icon: ReactionIcon(AppAssets.LOVE_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'haha',
                                        icon: ReactionIcon(AppAssets.HAHA_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'wow',
                                        icon: ReactionIcon(AppAssets.WOW_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'sad',
                                        icon: ReactionIcon(AppAssets.SAD_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'angry',
                                        icon:
                                            ReactionIcon(AppAssets.ANGRY_ICON),
                                      ),
                                      Reaction<String>(
                                        value: 'unlike',
                                        icon:
                                            ReactionIcon(AppAssets.UNLIKE_ICON),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.commentsID.value =
                                        '${commentModel.id}';
                                    controller.postID.value =
                                        '${commentModel.post_id}';

                                    FocusScope.of(context)
                                        .requestFocus(inputNodes);
                                    controller.isReply.value = true;
                                  },
                                  child: const Text('Reply'),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getCommentReplyReactions(
                                        '${commentModel.replies![index].post_id}',
                                        '${commentModel.replies![index].comment_id}',
                                        '${commentModel.replies![index].id}');

                                    //////////Reply Reaction//////////////////////////////////////////////////////////////////////////

                                    Get.bottomSheet(
                                      SizedBox(
                                        width: Get.width,
                                        height: Get.height - 300,
                                        child: Column(
                                          children: [
                                            /////////////////////////////////////////////////////////

                                            DefaultTabController(
                                              length: 8,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10.0),
                                                    child: TabBar(
                                                      tabAlignment:
                                                          TabAlignment.start,
                                                      indicatorSize:
                                                          TabBarIndicatorSize
                                                              .label,
                                                      indicator:
                                                          const UnderlineTabIndicator(
                                                        borderSide: BorderSide(
                                                          width: 2,
                                                          color: PRIMARY_COLOR,
                                                        ),
                                                      ),
                                                      isScrollable: true,
                                                      dividerColor: Colors.grey,
                                                      tabs: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'All',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyReactionList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/like_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyLikeList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/love_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyLoveList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/haha_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyHahaList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/wow_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyWowList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/sad_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replySadList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/icon/reaction/angry_icon.png',
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyAngryList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                AppAssets
                                                                    .UNLIKE_ICON,
                                                                height: 25,
                                                                width: 25,
                                                              ),
                                                              Obx(() => Text(
                                                                  ' ${controller.replyUnlikeList.value.length}')),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //====================================================================== Tab Bar View ======================================================================//

                                                  SizedBox(
                                                    height: Get.height - 360,
                                                    child: Obx(() => controller
                                                                .isReplyReactionLoading
                                                                .value ==
                                                            true
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : TabBarView(
                                                            children: [
                                                              // ==================================== All Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyReactionList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyReactionList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyReactionList.value[index];
                                                                        ReplyUserId?
                                                                            userIdModel =
                                                                            model.userId;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel?.firstName} ${userIdModel?.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel?.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              // ==================================== Like Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyLikeList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyLikeList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyLikeList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              //Text('Like'),

                                                              // ==================================== Love Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyLoveList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyLoveList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyLoveList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              //Text('Love'),
                                                              // ==================================== Haha Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyHahaList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyHahaList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyHahaList.value[index];

                                                                        debugPrint(
                                                                            '============Reply Reaction length ${controller.hahaList.value.length}=======================================================================');
                                                                        debugPrint(
                                                                            '============Reply Reaction Haha Model $model=======================================================================');

                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              //Text('Haha'),

                                                              // ==================================== Wow Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyWowList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyWowList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyWowList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              // Text('data'),
                                                              // ==================================== Sad Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replySadList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .sadList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replySadList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              //Text("Sad"),

                                                              // ==================================== Angry Reaction List ============================//

                                                              Obx(() => controller
                                                                      .replyAngryList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyAngryList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyAngryList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    )),

                                                              //Text("Sad"),

                                                              // ==================================== Unlike Reaction List ============================//

                                                              //Text('Unlike')

                                                              Obx(() => controller
                                                                      .replyUnlikeList
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount: controller
                                                                          .replyUnlikeList
                                                                          .value
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        ReplyReactions
                                                                            model =
                                                                            controller.replyUnlikeList.value[index];
                                                                        ReplyUserId
                                                                            userIdModel =
                                                                            model.userId!;
                                                                        return ReactionListTile(
                                                                          name:
                                                                              '${userIdModel.firstName} ${userIdModel.lastName}',
                                                                          profilePicUrl:
                                                                              getFormatedProfileUrl(userIdModel.profilePic ?? ''),
                                                                          reaction:
                                                                              getReactionIconPath(
                                                                            model.reactionType ??
                                                                                '',
                                                                          ),
                                                                        );
                                                                      },
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                          'No Reaction'),
                                                                    ))
                                                            ],
                                                          )),
                                                  )
                                                ],
                                              ),
                                            ),

                                            ///////////////////////////////////////////////
                                          ],
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                    );

                                    ////////////////////////////////////////////////////////////////////////////////////////////////////
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: Get.width / 8,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  commentModel
                                                      .replies![index]
                                                      .replies_comment_reactions!
                                                      .length;
                                              i++)
                                            Container(
                                              child: ReactionIcons(
                                                  '${commentModel.replies?[index].replies_comment_reactions?[i].reaction_type}'),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        LoginCredential().getUserData().id ==
                                commentModel.replies?[index].replies_user_id?.id
                            ? PopupMenuButton(
                                color: Colors.white,
                                offset: const Offset(140, 40),
                                iconColor: Colors.grey,
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.grey,
                                ),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.replyDelete(
                                              '${commentModel.replies?[index].id}',
                                              '${commentModel.replies?[index].post_id}');
                                        },
                                        value: 1,
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ])
                            : const SizedBox(
                                height: 0,
                                width: 50,
                              ),
                      ],
                    ),
                  );
                }),
          )

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ],
      ),
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 24, image: AssetImage(assetName));
  }

  Widget CommentReactionIcons(CommentModel commentModel) {
    Set<Image> postReactionIcons = {};
    if (commentModel.comment_reactions != null) {
      for (CommentReaction commentReaction in commentModel.comment_reactions!) {
        if (commentReaction.reaction_type == '') {}
        switch (commentReaction.reaction_type) {
          case 'like':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
          case 'love':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
            break;
          case 'haha':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
            break;
          case 'wow':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
            break;
          case 'sad':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
            break;
          case 'angry':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.ANGRY_ICON)));
            break;
          case 'unlike':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.UNLIKE_ICON)));
            break;
          default:
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
        }
      }
    }

    List<Image> reactionImageList = postReactionIcons.toList();

    if (reactionImageList.length > 3) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList.getRange(1, 3).toList());
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList);
    }
  }

  Widget ReplayReactionIcons(CommentReplay commentReplay) {
    List<Image> postReactionIcons = [];
    if (commentReplay.replies_comment_reactions != null) {
      for (RepliesCommentReaction repliesCommentReaction
          in commentReplay.replies_comment_reactions!) {
        if (repliesCommentReaction.reaction_type == '') {}
        switch (repliesCommentReaction.reaction_type) {
          case 'like':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
          case 'love':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
            break;
          case 'haha':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
            break;
          case 'wow':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
            break;
          case 'sad':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
            break;
          case 'angry':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.ANGRY_ICON)));
            break;
          case 'unlike':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.UNLIKE_ICON)));
            break;
          default:
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
        }
      }
    }

    List<Image> reactionImageList = postReactionIcons.toList();

    if (reactionImageList.length > 3) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList.getRange(1, 3).toList());
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList);
    }
  }

  Widget ReactionIcons(String reaction_type) {
    switch (reaction_type) {
      case 'like':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON));
      case 'love':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON));
      case 'haha':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON));
      case 'wow':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON));
      case 'sad':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON));
      case 'angry':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.ANGRY_ICON));
      case 'unlike':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.UNLIKE_ICON));
      default:
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON));
    }
  }
}
