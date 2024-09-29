import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/routes/app_pages.dart';

import '../../../models/post.dart';
import '../controllers/edit_post_controller.dart';
import 'edit_event_post.dart';
import 'edit_general_post.dart';

class EditPostView extends GetView<EditPostController> {
  EditPostView({Key? key}) : super(key: key);

  final PostModel? postModel = Get.arguments;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:  const Text(
      //     'Edit Post',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      // ),
      body: postModel!.event_type == null || postModel!.event_type == ''
          ? EditGeneralPostView(
              postModel: postModel,
            )
          : EditEventView(
              postModel: postModel,
            ),
    );
  }
}
