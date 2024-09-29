import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/api_constant.dart';
import '../../config/app_assets.dart';
import '../../modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
import '../../modules/NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';
import '../../data/login_creadential.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../models/user_id.dart';
import '../../routes/app_pages.dart';
import '../../utils/color.dart';
import '../../utils/image.dart';
import '../../utils/post_utlis.dart';
import '../image.dart';

class PostHeader extends StatelessWidget {
  final PostModel model;
  final VoidCallback onTapEditPost;

  PostHeader({
    super.key,
    required this.model,
    required this.onTapEditPost
  });

  RxString character = 'spam'.obs;

  TextEditingController reportDescription = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    UserIdModel userModel = model.user_id!;
    UserModel currentUserModel = LoginCredential().getUserData();
    return model.post_type == 'Shared'
        ? Container(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                if (LoginCredential().getUserData().username !=
                    userModel.username) {
                  Get.toNamed(Routes.OTHERS_PROFILE,
                      arguments: userModel.username);
                } else {
                  Get.toNamed(Routes.PROFILE);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  RoundCornerNetworkImage(
                    imageUrl: getFormatedProfileUrl(
                      model.share_post_id!.user_id!.profile_pic ?? '',
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
                                '${model.share_post_id!.user_id!.first_name} ${model.share_post_id!.user_id!.last_name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: ' ${getSharedHeaderTextAsPostType(model)}',
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 16))
                        ])),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${getDynamicFormatedTime(model.share_post_id!.createdAt ?? '')} '),
                            Text(
                              getTextAsPostType(
                                  model.share_post_id!.post_type ?? ''),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              getIconAsPrivacy(
                                  model.share_post_id!.post_privacy ?? ''),
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                if (LoginCredential().getUserData().username !=
                    userModel.username) {
                  Get.toNamed(Routes.OTHERS_PROFILE,
                      arguments: userModel.username);
                } else {
                  Get.toNamed(Routes.PROFILE);
                }

                // Get.toNamed(Routes.OTHERS_PROFILE,
                //     arguments: userModel.username);
              },
              child: Row(
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
                            children: [
                              model.feeling_id != null ?
                               WidgetSpan(child:  Padding(
                                 padding: const EdgeInsets.only(left: 3.0),
                                 child: ReactionIcon(model.feeling_id!.logo.toString()),
                               ) ): WidgetSpan(child: SizedBox()),

                              TextSpan(
                                  text: ' ${getHeaderTextAsPostType(model)}',
                                  style: TextStyle(
                                      color: Colors.grey.shade700, fontSize: 16))
                            ]
                          ),
                        ])),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${getDynamicFormatedTime(model.createdAt ?? '')} '),
                            Text(
                              getTextAsPostType(model.post_type ?? ''),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
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
                                    onTap: onTapEditPost,
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 14),
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
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
                                            controller.selectedPrivacyOption
                                                    .value =
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
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              value: 'public',
                                                              groupValue: controller
                                                                  .selectedPrivacyOption
                                                                  .value,
                                                              activeColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  (value) {
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
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              value: 'friends',
                                                              groupValue: controller
                                                                  .selectedPrivacyOption
                                                                  .value,
                                                              activeColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  (value) {
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
                                                                  Icon(Icons
                                                                      .lock),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Text(
                                                                    'Only Me',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              value: 'only_me',
                                                              groupValue: controller
                                                                  .selectedPrivacyOption
                                                                  .value,
                                                              activeColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  (value) {
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
                                                  height: 220,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      const Image(
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            AppAssets
                                                                .DELETE__ICON),
                                                      ),
                                                      const Text(
                                                        'Delete Post',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 20),
                                                      ),
                                                      const Text(
                                                          'Are you sure you want to delete this post ?'),
                                                      const Text(
                                                          'This action cannot be undone.'),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .grey,
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
                                                                  const Size(
                                                                      100,
                                                                      40), //////// HERE
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                ),
                                                              ),
                                                              minimumSize:
                                                                  const Size(
                                                                      100,
                                                                      40), //////// HERE
                                                            ),
                                                            onPressed: () {
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
                                                              'Delete',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
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
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.more_vert))
                      : IconButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              height: 60,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.report_outlined),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: GestureDetector(
                                          onTap: () async {
                                            ////////////////////report/////////////////////////////////////////////////

                                            Get.bottomSheet(
                                              SizedBox(
                                                height: Get.height / 1.8,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: const Text(
                                                        'Report',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 1,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    Expanded(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const ScrollPhysics(),
                                                        children: [
                                                          Obx(() => ListTile(
                                                                title:
                                                                    const Text(
                                                                        'Spam'),
                                                                subtitle:
                                                                    const Text(
                                                                        'It’s spam or violent'),
                                                                leading: Radio<
                                                                    String>(
                                                                  value: 'spam',
                                                                  groupValue:
                                                                      character
                                                                          .value,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    character
                                                                            .value =
                                                                        value!;
                                                                    // setState(() {
                                                                    //   _character = value;
                                                                    // });
                                                                  },
                                                                ),
                                                              )),
                                                          Obx(() => ListTile(
                                                                title: const Text(
                                                                    'False information'),
                                                                subtitle:
                                                                    const Text(
                                                                        'If someone is in immediate danger'),
                                                                leading: Radio<
                                                                    String>(
                                                                  value:
                                                                      'false_info',
                                                                  groupValue:
                                                                      character
                                                                          .value,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    character
                                                                            .value =
                                                                        value!;
                                                                    // setState(() {
                                                                    //   _character = value;
                                                                    // });
                                                                  },
                                                                ),
                                                              )),
                                                          Obx(() => ListTile(
                                                                title: const Text(
                                                                    'Nudity'),
                                                                subtitle:
                                                                    const Text(
                                                                        'It’s Sexual activity or nudity showing genitals'),
                                                                leading: Radio<
                                                                    String>(
                                                                  value:
                                                                      'nudity',
                                                                  groupValue:
                                                                      character
                                                                          .value,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    character
                                                                            .value =
                                                                        value!;
                                                                    // setState(() {
                                                                    //   _character = value;
                                                                    // });
                                                                  },
                                                                ),
                                                              )),
                                                          Obx(() => ListTile(
                                                                title: const Text(
                                                                    'Something Else'),
                                                                subtitle:
                                                                    const Text(
                                                                        'Fraud, scam, violence, hate speech etc. '),
                                                                leading: Radio<
                                                                    String>(
                                                                  value:
                                                                      'something_else',
                                                                  groupValue:
                                                                      character
                                                                          .value,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    character
                                                                            .value =
                                                                        value!;
                                                                    // setState(() {
                                                                    //   _character = value;
                                                                    // });
                                                                  },
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            width:
                                                                Get.width / 2,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width: 1)),
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            // Get.back();

                                                            Get.bottomSheet(
                                                              SizedBox(
                                                                height:
                                                                    Get.height /
                                                                        1.8,
                                                                width:
                                                                    Get.width,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              10),
                                                                      child:
                                                                          const Text(
                                                                        'Report',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      height: 1,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            'Description',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              Get.height / 2.9,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 20,
                                                                              vertical: 10),
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.grey.shade300, width: 1), //Colors.grey.withOpacity(0.1),width: 1),
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                reportDescription,
                                                                            maxLines:
                                                                                8,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: InputBorder.none,
                                                                              hintText: 'Enter a description about your Report...',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                Get.width / 2,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1)),
                                                                            child:
                                                                                const Text(
                                                                              'Back',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            homeController.reportAPost(
                                                                                post_id: '${model.id}',
                                                                                report_type: character.value,
                                                                                description: reportDescription.text);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                Get.width / 2,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.grey, width: 1),
                                                                                color: PRIMARY_COLOR
                                                                                //.withOpacity(0.7),
                                                                                ),
                                                                            child:
                                                                                const Text(
                                                                              'Report',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              isScrollControlled:
                                                                  true,
                                                            );
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  width: 0),
                                                              color:
                                                                  PRIMARY_COLOR,
                                                            ),
                                                            width:
                                                                Get.width / 2,
                                                            child: const Text(
                                                              'Continue',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                            );

                                            ////////////////report///////////////////////////////////////////////////
                                          },
                                          child: const Text(
                                            'Report',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                          icon: const Icon(Icons.more_vert))
                ],
              ),
            ),
          );
  }

  getIconAsPrivacy(String postPrivacy) {

    switch (postPrivacy) {
      case 'public':
        return Icons.public;
      case 'only_me':
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
        return '${getFeelingText(postModel)}${getLocationText(postModel)}${getTagText(postModel)}';
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

  String getFeelingText(PostModel postModel) {
    return (model.feeling_id?.feelingName != null)
        ? ' is feeling ${model.feeling_id?.feelingName}'
        : '';
  }

  String getLocationText(PostModel postModel) {
    return (model.location_id?.locationName != null)
        ? ' at ${model.location_id?.locationName}'
        : '';
  }

  String getTagText(PostModel postModel) {
    if (postModel.taggedUserList != null) {
      if (postModel.taggedUserList!.length == 1) {
        return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''}';
      } else if (postModel.taggedUserList!.length > 1) {
        return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''} and ${postModel.taggedUserList!.length - 1} others';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  String getSharedHeaderTextAsPostType(PostModel postModel) {
    switch (model.share_post_id!.post_type) {
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


  Widget ReactionIcon(String reactionPath) {
    return Image(height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath))
    );
  }

  String getFormatedFeelingUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
  }
}
