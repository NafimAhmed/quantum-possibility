import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/notification.dart';
import '../../../../models/notification.dart';
import '../../../../routes/app_pages.dart';
import '../../../notification_post/view/notification_post.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.search,
                  size: 30,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              'New',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => controller.isNotificationLoading.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.notificationList.value.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text('No notification found !!!'),
                        ),
                      )
                    : ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.notificationList.value.length,
                        itemBuilder: (context, index) {
                          NotificationModel notificationModel =
                              controller.notificationList.value[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.NOTIFICATION_POST,
                                  arguments: controller
                                      .notificationList
                                      .value[index]
                                      .notification_data!
                                      .postId!
                                      .id
                                      .toString());
                            },
                            child: NotificationItem(
                              model: notificationModel,
                            ),
                          );
                        },
                      ),
          ),
        ],
      )),
    );
  }
}
