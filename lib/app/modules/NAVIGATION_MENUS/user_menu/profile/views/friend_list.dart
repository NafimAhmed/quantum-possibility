import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/friend.dart';
import '../../../../../models/friend.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class FriendList extends GetView<ProfileController> {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Friends List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        //surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(.3)),
            child: const TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Search friends'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Obx(
                  () => RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Friends',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' (${controller.friendList.value.length.toString()})',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ])),
                )),

                // const Text(
                //   'Sell All',
                //   style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: PRIMARY_COLOR),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.friendList.value.length,
                  itemBuilder: (context, index) {
                    FriendModel friendModel =
                        controller.friendList.value[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.OTHERS_PROFILE,
                            arguments: friendModel.user_id?.username);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FriendCard(
                          model: friendModel, otherOptions: true,
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
