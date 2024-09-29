import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/multiple_image_tile.dart';
import '../../../../components/post/post_header.dart';
import '../../../../models/post.dart';
import '../../../../utils/image.dart';
import '../controller/multiple_image_controller.dart';

class MultipleImageView extends GetView<MultipleImageContoller> {
  //final String text;
  final PostModel postModel;

  const MultipleImageView({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "${postModel.user_id?.first_name}'S Post",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          PostHeader(model: postModel,onTapEditPost: (){

          },),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                    width: Get.width - 20,
                    child: postModel.post_type == 'Shared'
                        ? Text(
                            '${postModel.share_post_id!.description}',
                            textAlign: TextAlign.start,
                          )
                        : Text(
                            '${postModel.description}',
                            textAlign: TextAlign.start,
                          )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: postModel.post_type == 'Shared'
                    ? postModel.shareMedia?.length
                    : postModel.media?.length,
                itemBuilder: (context, index) {
                  return MultipleImageTile(
                      imageUrl: postModel.post_type == 'Shared'
                          ? getFormatedPostUrl(
                              '${postModel.shareMedia?[index].media}')
                          : getFormatedPostUrl(
                              '${postModel.media?[index].media}'),
                      //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
                      model: postModel,
                      onSelectReaction: (reaction) {},
                      onPressedComment: () {},
                      onPressedShare: () {},
                      onTapViewReactions: () {});
                }),
          ),
        ],
      ),
    );
  }
}
