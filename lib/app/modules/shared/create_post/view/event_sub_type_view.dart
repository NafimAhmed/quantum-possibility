import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../components/button.dart';
import '../../../../components/event_sub_type_body.dart';
import '../controller/create_post_controller.dart';

class EventSubTypeView extends GetView<CreatePostController>{


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
        child: EventSubTypeBody(
          imageLink: 'assets/icon/live_event/work_event_icon.png',
          title: eventTypeTitle,
          onPressed: () {
            controller.onTapCreateEventPost();
          },
          controller: controller,),
      )


    );
  }
  
}