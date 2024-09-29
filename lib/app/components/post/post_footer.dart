import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
import '../../config/app_assets.dart';
import '../../data/login_creadential.dart';
import '../../models/post.dart';
import '../../modules/share_post/controllers/share_post_controller.dart';
import '../../utils/color.dart';
import '../../utils/image.dart';
import '../../utils/post_utlis.dart';
import '../button.dart';
import '../image.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
    required this.model,
    required this.onSelectReaction,
    required this.onPressedComment,
    required this.onPressedShare,
    required this.onTapViewReactions,
  });

  final PostModel model;
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final VoidCallback onTapViewReactions;



  // SharePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            InkWell(onTap: onTapViewReactions, child: PostReactionIcons(model)),
            Expanded(
              child: Row(
                children: [
                  (model.reactionCount ?? 0) > 0
                      ? Text(' ${model.reactionCount}')
                      : const Text(' No reaction'),
                ],
              ),
            ),
            InkWell(
                onTap: onPressedComment,
                child: Text('${model.totalComments} Comments ')),
          ],
        ),
        const Divider(),
        BottomAction(
          onSelectReaction: onSelectReaction,
          onPressedComment: onPressedComment,
          onPressedShare: onPressedShare,
          model: model,
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(color: Colors.grey.shade300),
        )
      ],
    );
  }
}

//=============================================================== Post Reaction List

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

  List<Image> postReactionList = postReactionIcons.toList();
  if (postReactionList.length > 3) {
    return Row(children: postReactionList.getRange(0, 2).toList());
  } else {
    return Row(children: postReactionList);
  }
}

//=============================================================== Like, Comment, Share button

Reaction<String>? getSelectedReaction(PostModel postModel) {
  ReactionModel? reactionModel = postModel.reactionTypeCountsByPost?.firstWhere(
    (element) => element.user_id == '6514147376594264b1103efe',
    orElse: () => ReactionModel(count: -1),
  );
  if (reactionModel != null) {
    if (reactionModel.count != -1) {
      return getReactionAsReactionType(reactionModel.reaction_type ?? '');
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Reaction<String> getReactionAsReactionType(String type) {
  if (type == 'like') {
    return Reaction<String>(
      value: 'like',
      icon: ReactionIcon(AppAssets.LIKE_ICON),
    );
  } else if (type == 'love') {
    return Reaction<String>(
      value: 'love',
      icon: ReactionIcon(AppAssets.LOVE_ICON),
    );
  } else if (type == 'haha') {
    return Reaction<String>(
      value: 'haha',
      icon: ReactionIcon(AppAssets.HAHA_ICON),
    );
  } else if (type == 'wow') {
    return Reaction<String>(
      value: 'wow',
      icon: ReactionIcon(AppAssets.WOW_ICON),
    );
  } else if (type == 'sad') {
    return Reaction<String>(
      value: 'sad',
      icon: ReactionIcon(AppAssets.SAD_ICON),
    );
  } else if (type == 'angry') {
    return Reaction<String>(
      value: 'angry',
      icon: ReactionIcon(AppAssets.ANGRY_ICON),
    );
  } else if (type == 'unlike') {
    return Reaction<String>(
      value: 'unlike',
      icon: ReactionIcon(AppAssets.UNLIKE_ICON),
    );
  } else {
    return Reaction<String>(
      value: 'like',
      icon: ReactionIcon(AppAssets.LIKE_ICON),
    );
  }
}

class BottomAction extends StatelessWidget {
  const BottomAction({
    super.key,
    required this.onSelectReaction,
    required this.onPressedComment,
    required this.onPressedShare,
    required this.model,
  });
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [




        Expanded(
          child: Row(
            children: [
              const SizedBox(width: 10),
              ReactionButton<String>(
                itemSize: const Size(32, 32),
                onReactionChanged: (Reaction<String>? reaction) {
                  onSelectReaction(reaction?.value ?? '');
                },
                placeholder: Reaction<String>(
                  value: 'like',
                  icon: Row(
                    children: [
                      ReactionIcon(AppAssets.LIKE_ACTION_ICON),
                      const SizedBox(width: 10),
                      Text('Like',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ))
                    ],
                  ),
                ),
                isChecked: getSelectedReaction(model) != null,
                selectedReaction: getSelectedReaction(model),
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
            ],
          ),
        ),




        Expanded(
          child: PostActionButton(
            assetName: AppAssets.COMMENT_ACTION_ICON,
            text: 'Comment',
            onPressed: onPressedComment,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [



              PostActionButton(
                assetName: AppAssets.SHARE_ACTION_ICON,
                text: 'Share',
                onPressed: () {

                  HomeController controller=Get.find();
                  //SharePostController controller = Get.put(SharePostController());

                  controller.descriptionController.clear();
                  Get.bottomSheet(
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                NetworkCircleAvatar(
                                    imageUrl: getFormatedProfileUrl(
                                        LoginCredential()
                                                .getUserData()
                                                .profile_pic ??
                                            '')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 25,
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: PRIMARY_COLOR, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(
                                            Icons.public,
                                            color: PRIMARY_COLOR,
                                            size: 15,
                                          ),
                                          Obx(() => DropdownButton<String>(
                                                value: controller
                                                    .dropdownValue.value,
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: PRIMARY_COLOR,
                                                ),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: PRIMARY_COLOR),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.transparent,
                                                ),
                                                onChanged: (String? value) {
                                                  controller.dropdownValue
                                                      .value = value!;
                                                  if (value == 'Public') {
                                                    controller.postPrivacy
                                                        .value = 'public';
                                                  } else if (value ==
                                                      'Friends') {
                                                    controller.postPrivacy
                                                        .value = 'friends';
                                                  } else {
                                                    controller.postPrivacy
                                                        .value = 'only_me';
                                                  }
                                                },
                                                items: SharePostController.list
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  );
                                                }).toList(),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: TextField(
                              controller: controller.descriptionController,
                              maxLines: 10,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                hintText:
                                    'What’s on your mind ${controller.userModel.first_name}?',
                              ),
                              onChanged: (value) {
                                debugPrint(
                                    'Update model status code on chage.............${controller.descriptionController.text}');
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  height: 45,
                                  child: PrimaryButton(
                                    onPressed: () async {
                                      Get.back();
                                      await controller.shareUserPost(model.id.toString());
                                    },
                                    text: 'Share Now',
                                    fontSize: 14,
                                    verticalPadding: 10,
                                    horizontalPadding: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Share to',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                height: 30,
                                image: AssetImage(
                                    'assets/image/facebook-logo.png'),
                              ),
                              Image(
                                height: 30,
                                image: AssetImage(
                                    'assets/image/messenger-logo.png'),
                              ),
                              Image(
                                height: 30,
                                image:
                                    AssetImage('assets/image/twitter-logo.png'),
                              ),
                              Image(
                                height: 30,
                                image: AssetImage(
                                    'assets/image/whatsapp-logo.png'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    backgroundColor: Colors.white,
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 24, image: AssetImage(assetName));
  }
}
