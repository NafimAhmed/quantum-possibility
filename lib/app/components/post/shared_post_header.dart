import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
import '../../modules/NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';

import '../../data/login_creadential.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../models/user_id.dart';
import '../../routes/app_pages.dart';
import '../../utils/image.dart';
import '../../utils/post_utlis.dart';
import '../image.dart';

class SharedPostHeader extends StatelessWidget {
  final PostModel model;

  const SharedPostHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    UserIdModel userModel = model.user_id!;
    UserModel currentUserModel = LoginCredential().getUserData();
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.OTHERS_PROFILE, arguments: userModel);
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                RoundCornerNetworkImage(
                  imageUrl: getFormatedProfileUrl(
                    userModel.profile_pic ?? '',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text:
                              '${userModel.first_name} ${userModel.last_name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                            text: ' ${getHeaderTextAsPostType(model)}',
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16))
                      ])),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${getDynamicFormatedTime(model.createdAt ?? '')} '),
                          Text(
                            getTextAsPostType(model.post_type ?? ''),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            getIconAsPrivacy(model.post_privacy ?? ''),
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // =========================================================== Three Dot Icon ===========================================================
                model.user_id?.id == currentUserModel.id
                    ? IconButton(
                        onPressed: () {
                          Get.bottomSheet(Container(
                            height: 160,
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Routes.EDIT_POST;
                                  },
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Navigator.of(context).pop(false);
                                          Get.toNamed(Routes.EDIT_POST,
                                              arguments: model);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 14),
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          Navigator.of(context).pop(false);
                                          Get.toNamed(Routes.EDIT_POST,
                                              arguments: model);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.lock,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: GestureDetector(
                                        onTap: () async {
                                          ProfileController controller =
                                              Get.put(ProfileController());
                                          controller
                                                  .selectedPrivacyOption.value =
                                              model.post_privacy.toString();
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: SizedBox(
                                                  height: 200,
                                                  child: Obx(() => Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          RadioListTile(
                                                            title: const Row(
                                                              children: <Widget>[
                                                                Icon(Icons
                                                                    .public),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Text(
                                                                  'Public',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            value: 'public',
                                                            groupValue: controller
                                                                .selectedPrivacyOption
                                                                .value,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged: (value) {
                                                              controller
                                                                  .selectedPrivacyOption
                                                                  .value = value!;
                                                              controller
                                                                  .updatePostPrivacy(
                                                                      model.id
                                                                          .toString());
                                                              Get.back();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              controller
                                                                  .getPosts();
                                                              debugPrint(
                                                                  'post privacy ::::${model.post_privacy}');
                                                              HomeController()
                                                                  .getPosts();
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Row(
                                                              children: <Widget>[
                                                                Icon(Icons
                                                                    .person_3),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Text(
                                                                  'Friends',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            value: 'friends',
                                                            groupValue: controller
                                                                .selectedPrivacyOption
                                                                .value,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged: (value) {
                                                              controller
                                                                  .selectedPrivacyOption
                                                                  .value = value!;
                                                              controller
                                                                  .updatePostPrivacy(
                                                                      model.id
                                                                          .toString());
                                                              Get.back();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              controller
                                                                  .getPosts();
                                                              HomeController()
                                                                  .getPosts();
                                                              // HomeController().getStories();
                                                            },
                                                          ),
                                                          RadioListTile(
                                                            title: const Row(
                                                              children: <Widget>[
                                                                Icon(
                                                                    Icons.lock),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Text(
                                                                  'Only Me',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            value: 'only_me',
                                                            groupValue: controller
                                                                .selectedPrivacyOption
                                                                .value,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged: (value) {
                                                              controller
                                                                  .selectedPrivacyOption
                                                                  .value = value!;
                                                              controller
                                                                  .updatePostPrivacy(
                                                                      model.id
                                                                          .toString());
                                                              Get.back();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              controller
                                                                  .getPosts();
                                                              HomeController()
                                                                  .getPosts();
                                                              // HomeController().getStories();
                                                            },
                                                          ),
                                                        ],
                                                      ))),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Privacy',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                        'Are you sure you want to delete this post ?'),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 25.0),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 1),
                                                              // shadowColor: Colors.greenAccent,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                              minimumSize:
                                                                  const Size(50,
                                                                      30), //////// HERE
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              ProfileController
                                                                  controller =
                                                                  Get.put(
                                                                      ProfileController());
                                                              HomeController
                                                                  homeController =
                                                                  Get.put(
                                                                      HomeController());
                                                              controller
                                                                  .deletePost(model
                                                                      .id
                                                                      .toString());
                                                              Get.back();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              controller
                                                                  .postList
                                                                  .value
                                                                  .removeWhere((element) =>
                                                                      element
                                                                          .id ==
                                                                      model.id
                                                                          .toString());
                                                              homeController
                                                                  .postList
                                                                  .value
                                                                  .removeWhere((element) =>
                                                                      element
                                                                          .id ==
                                                                      model.id
                                                                          .toString());
                                                              controller
                                                                  .postList
                                                                  .refresh();
                                                              homeController
                                                                  .postList
                                                                  .refresh();
                                                            },
                                                            child: const Text(
                                                              'yes',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 25.0),
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 1),
                                                              // shadowColor: Colors.greenAccent,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                              minimumSize:
                                                                  const Size(50,
                                                                      30), //////// HERE
                                                            ),
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.file_copy,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Copy link',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                        },
                        icon: const Icon(Icons.more_vert))
                    : Container()
              ],
            ),
            Container(
              // =================================================== No Meida Post ===================================================
              height: (model.post_background_color != null &&
                      model.post_background_color!.isNotEmpty &&
                      model.post_background_color! != '')
                  ? 256
                  : null, // not having background color will make height dynamic
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: (model.post_background_color != null &&
                          model.post_background_color!.isNotEmpty)
                      ? Color(int.parse('0xff${model.post_background_color}'))
                      : null),
              padding: const EdgeInsets.all(10),
              child: (model.post_background_color != null &&
                      model.post_background_color != '')
                  ? Center(
                      child: Text(
                        '${model.description}',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ExpandableText(
                      '${model.description}',
                      expandText: 'See more',
                      maxLines: 5,
                      collapseText: 'see less',
                      style: const TextStyle(color: Colors.black),
                    ),
            )
          ],
        ),
      ),
    );
  }

  getIconAsPrivacy(String postPrivacy) {
    switch (postPrivacy) {
      case 'public':
        return Icons.public;
      case 'private':
        return Icons.lock;
      case 'friends':
        return Icons.group;
      default:
        return Icons.public;
    }
  }

  String getTextAsPostType(String postType) {
    switch (postType) {
      case 'campaign':
        return 'Sponsored ';
      default:
        return '';
    }
  }

  String getHeaderTextAsPostType(PostModel postModel) {
    switch (model.post_type) {
      case 'timeline_post':
        return '';
      case 'page_post':
        return '';
      case 'profile_picture':
        return 'updated his profile picture';
      case 'cover_picture':
        return 'updated his cover photo';
      case 'event':
        return '';
      case 'shared_reels':
        return '';
      case 'birthday':
        return '';
      case 'campaign':
        return '';
      default:
        return '';
    }
  }
}
