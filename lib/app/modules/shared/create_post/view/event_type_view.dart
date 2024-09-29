import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/event_body.dart';
import '../controller/create_post_controller.dart';

class EventTypeView extends GetView<CreatePostController> {


  List<String> item = [
    "New Job",
    "Promotion",
    "Left Job",
    "Retirement"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: EventBody(item: item,
        imageLink: 'assets/icon/live_event/work_event_icon.png', title: 'Work Life Event',

      )

    );
  }

}