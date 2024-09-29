import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/data/post_color_list.dart';

import '../../../../components/image.dart';
import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/feeling_model.dart';
import '../../../../models/location_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/color.dart';
import '../../../../utils/image.dart';
import '../../../../utils/post_type.dart';
import '../controller/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Create Post',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: controller.onTapCreatePost,
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                NetworkCircleAvatar(
                    imageUrl: getFormatedProfileUrl(
                        LoginCredential().getUserData().profile_pic ?? '')),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [


                            TextSpan(
                              text:
                                  '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            controller.feelingName.value != null
                                ?
                            TextSpan(
                               children: [
                                 TextSpan(
                                     children: [
                                       TextSpan(
                                           text: ' is feeling',
                                           style: TextStyle(
                                               color: Colors.grey.shade700,
                                               fontSize: 16)),
                                       TextSpan(
                                           text:
                                           ' ${controller.feelingName.value?.feelingName}',
                                           style: const TextStyle(
                                               color: Colors.black,
                                               fontSize: 16,
                                               fontWeight: FontWeight.bold)),
                                     ],
                                     style: TextStyle(
                                         color: Colors.grey.shade700,
                                         fontSize: 16)),
                                 WidgetSpan(child:  Padding(
                                   padding: const EdgeInsets.only(left: 3.0),
                                   child: ReactionIcon(controller.feelingName.value!.logo.toString()

                                   ),
                                 ) ),
                               ]
                            )
                                : TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                            controller.locationName.value != null
                                ? TextSpan(
                                    children: [
                                        TextSpan(
                                            text: ' at',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 16)),
                                        TextSpan(
                                            text:
                                                ' ${controller.locationName.value?.locationName}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16))
                                : TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                            controller.checkFriendList.value.length == 1
                                ? TextSpan(
                                    children: [
                                        TextSpan(
                                            text: ' with',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 16)),
                                        TextSpan(
                                            text:
                                                ' ${controller.checkFriendList.value[0].user_id!.username.toString()}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16))
                                : controller.checkFriendList.value.length > 1
                                    ? TextSpan(
                                        children: [
                                            TextSpan(
                                                text: ' with',
                                                style: TextStyle(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 16)),
                                            TextSpan(
                                                text:
                                                    ' ${controller.checkFriendList.value[0].user_id!.username.toString()} and ${controller.checkFriendList.value.length - 1} others',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16))
                                    : TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16)),
                          ])),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 25,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: PRIMARY_COLOR, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.public,
                                  color: PRIMARY_COLOR,
                                  size: 15,
                                ),
                                Obx(() => DropdownButton<String>(
                                      value: controller.dropdownValue.value,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: PRIMARY_COLOR,
                                      ),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: PRIMARY_COLOR),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.transparent,
                                      ),
                                      onChanged: (String? value) {
                                        controller.dropdownValue.value = value!;
                                      },
                                      items: CreatePostController.list
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Obx(
            () => controller.isBackgroundColorPost.value
                ?
            Container(
                    width: double.maxFinite,
                    height: 240,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.textInputColor.value,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 20),
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            'What’s on your mind ${controller.userModel.first_name}?',
                      ),
                    ),
                  )
                : TextField(
                    onTap: () {
                      controller.isTapped.value = true;
                    },
                    controller: controller.descriptionController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      //alignLabelWithHint: false,
                      fillColor: controller.textInputColor.value,
                      filled: true,
                      border: InputBorder.none,
                      hintText:
                          'What’s on your mind ${controller.userModel.first_name}?',
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: controller.textInputColor.value ==
                                  const Color(0xfff8f6f6)
                              ? Colors.black
                              : const Color(0xfff8f6f6)),
                    ),
                  ),
          ),
          Container(
            width: Get.width,
            height: 35,
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: postListColor.length,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller.isBackgroundColorPost.value = true;
                    controller.textInputColor.value = postListColor[index];

                    var myColor = controller.textInputColor.value;

                    var hex = myColor.value.toRadixString(16);

                    debugPrint(
                        '========Hex Color ${controller.splitString(hex)}=======');
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 20,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: postListColor[index]),
                  ),
                );
              },
            ),
          ),
          Obx(() => Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                child: Wrap(
                    children: controller.xfiles.value
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image(
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  image: FileImage(File(e.path))),
                            ))
                        .toList()),
              )),
          Expanded(
            child: Card(
              shadowColor: Colors.black,
              elevation: 4,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          controller.pickFiles();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PostType(
                              icon: Image.asset(
                                'assets/icon/create_post/picture icon.png',
                                height: 30,
                                width: 30,
                              ),
                              title: 'Photo/Video',
                            ),
                            Obx(() => Text(
                                  '${controller.xfiles.value.length} Added ',
                                  style: const TextStyle(fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.TAG_PEOPLE);
                        },
                        child: PostType(
                          icon: Image.asset(
                            'assets/icon/create_post/tagpeople.png',
                            height: 30,
                            width: 30,
                          ),
                          title: 'Tag People',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          controller.feelingName.value =
                              await Get.toNamed(Routes.FEELINGS) as PostFeeling;

                          debugPrint(controller.feelingName.value.toString());
                        },
                        child: PostType(
                          icon: Image.asset(
                            'assets/icon/create_post/feelings.png',
                            height: 30,
                            width: 30,
                          ),
                          title: 'Feelings',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          controller.locationName.value =
                              await Get.toNamed(Routes.CHECKIN) as AllLocation;

                          debugPrint(controller.locationName.value.toString());
                        },
                        child: const PostType(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.pink,
                            size: 35,
                          ),
                          title: 'Check in',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EVENT);
                        },
                        child: PostType(
                          icon: Image.asset(
                            'assets/icon/create_post/liveevent.png',
                            height: 30,
                            width: 30,
                          ),
                          title: 'Life Event',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ReactionIcon(String reactionPath) {
    return Image(height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath)));
  }

  String getFormatedFeelingUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
  }
}
