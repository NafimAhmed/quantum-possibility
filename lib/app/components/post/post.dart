import 'package:flutter/material.dart';

import '../../models/post.dart';
import 'group_post_header.dart';
import 'post_body/post_body.dart';
import 'post_footer.dart';
import 'post_header.dart';
import 'shared_post_header.dart';

class PostCard extends StatelessWidget {
  //ApiCommunication _apiCommunication=Get.put(ApiCommunication());

  //HomeController controller=Get.put(HomeController());

   PostCard(
      {super.key,
      required this.model,
      required this.onSelectReaction,
      required this.onPressedComment,
      required this.onPressedShare,
      required this.onTapBodyViewMoreMedia, this.onTapEditPost,
      required this.onTapViewReactions,
      this.index});

  final PostModel model;
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final VoidCallback onTapBodyViewMoreMedia;
  final VoidCallback onTapViewReactions;
  final VoidCallback? onTapEditPost;
  final index;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: model.post_type == 'Shared'
          ? Column(
              children: [
                SharedPostHeader(model: model),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      PostHeader(
                        model: model,
                        onTapEditPost: onTapEditPost??(){},
                      ),
                      const SizedBox(height: 10),
                      PostBodyView(
                        model: model,
                        onTapBodyViewMoreMedia: onTapBodyViewMoreMedia,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PostFooter(
                    model: model,
                    onSelectReaction: onSelectReaction,
                    onPressedComment: onPressedComment,
                    onPressedShare: onPressedShare,
                    onTapViewReactions: onTapViewReactions),
              ],
            )
          : Column(
              children: [
                model.groupId!.groupName!.length > 1
                    ? GroupPostHeader(model: model)
                    : PostHeader(model: model,onTapEditPost: onTapEditPost??(){},),
                const SizedBox(height: 10),
                PostBodyView(
                  model: model,
                  onTapBodyViewMoreMedia: onTapBodyViewMoreMedia,
                ),
                const SizedBox(height: 10),
                PostFooter(
                    model: model,
                    onSelectReaction: onSelectReaction,
                    onPressedComment: onPressedComment,
                    onPressedShare: onPressedShare,
                    onTapViewReactions: onTapViewReactions),
              ],
            ),
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 32, image: AssetImage(assetName));
  }
}
