import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../models/post.dart';

import '../../../components/EditEducationEventBody.dart';
import '../../../components/EditWorkEventBody.dart';
import '../../../components/event_sub_type_body.dart';
import '../controllers/edit_post_controller.dart';

class EditEventView extends GetView<EditPostController> {
  const EditEventView({Key? key,required this.postModel}) : super(key: key);

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: postModel!.event_type.toString() == 'work' ?
        EditWorkEventBody(
          imageLink: 'assets/icon/live_event/work_event_icon.png',
          title: postModel!.event_sub_type.toString(),
          onPressed: () async {
            await controller.updateUserLifeEvent(postModel!.user_id!.username.toString(), postModel!.id.toString());
          },
          controller: controller, postModel: postModel,) :
        EditEducationBody(
          imageLink: 'assets/icon/live_event/education_event_icon.png',
          title: postModel!.event_sub_type.toString(), onPressed: () async {
          await controller.updateUserLifeEvent(postModel!.user_id!.username.toString(), postModel!.id.toString());
        },
          controller: controller, postModel: postModel,),
      ),
    );
  }
}