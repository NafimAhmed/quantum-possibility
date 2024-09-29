import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/button.dart';
import '../../../../components/friend.dart';
import '../../../../components/friend_request.dart';
import '../../../../components/people_may_you_khnow.dart';
import '../../../../models/firend_request.dart';
import '../../../../models/friend.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/color.dart';
import '../controllers/friend_controller.dart';
import '../model/people_may_you_khnow.dart';

class FriendView extends GetView<FriendController> {
  const FriendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Connection',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryButton(
                    horizontalPadding: Get.width/20,
                    verticalPadding: 10,
                    fontSize: 14,
                    onPressed: () {
                      controller.isRequestVisible.value = true;
                      controller.isFriendVisible.value = false;
                    },
                    text: 'Connection Request',
                  ),
                  PrimaryButton(
                    horizontalPadding: Get.width/13,
                    verticalPadding: 10,
                    fontSize: 14,
                    onPressed: () {
                      controller.viewType.value = 2;
                      controller.isRequestVisible.value = false;
                      controller.isFriendVisible.value = true;
                    },
                    text: 'My Connection',
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(),
              //============================================== Connection Request ==============================================//
              const SizedBox(height: 10),
              Obx(() => Visibility(
                    visible: controller.isFriendVisible.value,
                    child: FriendsView(),
                  )),
              Obx(() => Visibility(
                    visible: controller.isRequestVisible.value,
                    child: RequestView(),
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget RequestView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'Connections request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${controller.friendRequestList.value.length.toString()}',
                    style: const TextStyle(
                      color: ACCENT_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
              ),
              const Text(
                'See All',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.friendRequestList.value.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            FriendRequestModel friendRequestModel =
                controller.friendRequestList.value[index];
            return FriendRequestCard(
              friendRequestModel: friendRequestModel,
              onPressedAccept: () {
                controller.actionOnFriendRequest(
                    action: 1, requestId: friendRequestModel.id!);
              },
              onPressedReject: () {
                controller.actionOnFriendRequest(
                    action: 0, requestId: friendRequestModel.id!);
              },
            );
          },
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'People may you know',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${controller.peopleMayYouKnowModelList.value.length.toString()}',
                    style: const TextStyle(
                      color: ACCENT_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
              ),
              const Text(
                'See All',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.peopleMayYouKnowModelList.value.length,
          itemBuilder: (context, index) {
            PeopleMayYouKnowModel peopleMayYouKnowModel =
                controller.peopleMayYouKnowModelList.value[index];
            return PeopleMayYouKnowCard(
              peopleMayYouKnowModel: peopleMayYouKnowModel,
              onPressedAddFriend: () {
                controller.sendFriendRequest(
                  index: index,
                  userId: peopleMayYouKnowModel.id ?? '',
                );
              },
              onPressedRemove: () {},
            );
          },
        ),
      ],
    );
  }

  Widget FriendsView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
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
                    text: ' ${controller.friendList.value.length.toString()}',
                    style: const TextStyle(
                      color: ACCENT_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
              ),
              const Text(
                'Sell All',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.friendList.value.length,
          itemBuilder: (context, index) {
            FriendModel friendModel = controller.friendList.value[index];
            return InkWell(
              onTap: (){
                Get.toNamed(Routes.OTHERS_PROFILE, arguments: friendModel.user_id?.username);
              },
              child: FriendCard(
                model: friendModel, otherOptions: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
