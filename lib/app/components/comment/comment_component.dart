// import 'dart:ffi';

import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
import 'package:quantum_possibilities_flutter/app/utils/color.dart';
import '../image.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../config/app_assets.dart';
import '../../models/comment_model.dart';
import '../../utils/image.dart';
import 'comment_tile.dart';

class CommentComponent extends StatelessWidget {
  CommentComponent({
    super.key,
    required this.postModel,
    required this.userModel, // Current User
    required this.onTapSendComment,
    required this.commentController,
    required this.onSelectCommentReaction,
    required this.onSelectCommentReplayReaction,
    required this.onTapViewReactions,
    required this.onTapReplayComment,
  });

  final FocusNode focusNode = FocusNode();

  final PostModel postModel;
  final UserModel userModel;
  final VoidCallback onTapSendComment;
  final TextEditingController commentController;
  final Function(String reaction) onSelectCommentReaction;
  final Function(String reaction) onSelectCommentReplayReaction;
  final VoidCallback onTapViewReactions;
  final Function({required String comment_id, required String commentReplay})
      onTapReplayComment;
  @override
  Widget build(BuildContext context) {
    List<CommentModel> commentList = postModel.comments ?? [];

    //RxList<CommentModel> commentList1=commentList.obs;

    HomeController controller = Get.put(HomeController());

    RxBool emojiShowing = true.obs;

    return SizedBox(
      height: Get.height - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ===================================================== Comment List Header =====================================================//
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: onTapViewReactions,
                      child: PostReactionIcons(postModel),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      (postModel.reactionCount ?? 0).toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Text('${postModel.totalComments} Comments')
              ],
            ),
          ),
          // ===================================================== Comment List =====================================================//
          Expanded(
            child: //Obx(() => commentList1.value.length==0? Text('Comments'):

                ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: commentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, commentIndex) {
                      CommentModel commentModel = commentList[commentIndex];
                      return CommentTile(
                        commentModel: commentModel,
                        inputNodes: focusNode,
                        textEditingController: commentController,
                        onSelectCommentReaction: (reaction) {
                          controller.commentReaction(
                            reaction,
                            '${commentModel.post_id}',
                            '${commentModel.id}',
                          );
                        },
                        onSelectCommentReplayReaction: (reaction) {},
                        index: commentIndex,
                      );
                    }),
            //),
          ),

          Center(
            child: Obx(
              () => controller.isLoadingNewsFeed.value == true
                  ? const CircularProgressIndicator()
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ),
          ),

          // ===================================================== Post new Comment =====================================================//
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RoundCornerNetworkImage(
                    imageUrl:
                        getFormatedProfileUrl(userModel.profile_pic ?? '')),
              ),
              Container(
                height: 40,
                width: Get.width - 80,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey
                        .withOpacity(0.1), //Color.fromARGB(135, 238, 238, 238),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: commentController,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: 'Comment as ${userModel.first_name} ...',
                            hintStyle: const TextStyle(fontSize: 15),
                            border: InputBorder.none),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint('=============photo clicked======');
                            controller.pickFiles();
                          },
                          child: const Image(
                              height: 24,
                              image: AssetImage(AppAssets.IMAGE_COMMENT_ICON)),
                        ),
                        const SizedBox(width: 10),

                        //////////////////////////////////////////////////////////////////////////////////////

                        InkWell(
                          onTap: () {
                            if (emojiShowing.value == false) {
                              emojiShowing.value = true;
                            } else {
                              emojiShowing.value = false;
                            }

                            // _emojiShowing.value!=_emojiShowing.value;
                          },
                          child: const Image(
                              height: 24,
                              image: AssetImage(AppAssets.REACT_COMMENT_ICON)),
                        ),

                        ///////////////////////////////////////////////////////////////////////////////

                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            if (controller.isReply.value == false) {
                              onTapSendComment();
                            } else {
                              // controller.commentReply(
                              //     controller.commentsID.value,
                              //     '${LoginCredential().getUserData().id}',
                              //     commentController.text,
                              //     controller.postID.value);
                              onTapReplayComment(
                                  comment_id: controller.commentsID.value,
                                  commentReplay: commentController.text);
                              controller.isReply.value = false;
                              commentController.clear();
                            }
                          },
                          child: const Image(
                              height: 24,
                              image: AssetImage(AppAssets.SEND_COMMENT_ICON)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Obx(() => controller.xfiles.value.isEmpty
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : Container(
                  width: Get.width - 50,
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                            children: controller.xfiles.value
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                          image: FileImage(File(e.path))),
                                    ))
                                .toList()),
                        IconButton(
                            onPressed: () {
                              controller.xfiles.value.clear();
                              controller.xfiles.refresh();
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                )),

          Obx(
            () => Offstage(
              offstage: emojiShowing.value,
              child: EmojiPicker(
                textEditingController: commentController,
                //scrollController: _scrollController,
                config: Config(
                  height: 256,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 28 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.2
                            : 1.0),
                  ),
                  swapCategoryAndBottomBar: false,
                  skinToneConfig: const SkinToneConfig(),
                  categoryViewConfig: const CategoryViewConfig(
                    indicatorColor: PRIMARY_COLOR,
                    iconColorSelected: PRIMARY_COLOR,
                  ),
                  bottomActionBarConfig: const BottomActionBarConfig(
                    backgroundColor: Colors.transparent,
                    buttonColor: Colors.transparent,
                    buttonIconColor: Colors.grey,
                  ),
                  searchViewConfig:
                      const SearchViewConfig(backgroundColor: PRIMARY_COLOR),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

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
              height: 24, width: 24, image: AssetImage(AppAssets.ANGRY_ICON)));
          break;
        case 'unlike':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.UNLIKE_ICON)));
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
