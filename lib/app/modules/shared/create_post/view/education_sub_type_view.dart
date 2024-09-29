import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/education_sub_type_body.dart';
import '../controller/create_post_controller.dart';

class EducationSubTypeView extends GetView<CreatePostController>{


  var eventTypeTitle = Get.arguments;

  CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {

    controller.eventSubType.value = eventTypeTitle.toString();

    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            'Create life event',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: EducationSubTypeBody(
            imageLink: 'assets/icon/live_event/education_event_icon.png',
            title: eventTypeTitle,
            onPressed: () {
              controller.onTapCreateEventPost();
            },
            controller: controller,),
        )


    );
  }

}