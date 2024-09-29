import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/login_creadential.dart';
import '../modules/NAVIGATION_MENUS/friend/controllers/friend_controller.dart';
import '../models/friend.dart';
import '../utils/color.dart';
import '../utils/image.dart';

import 'image.dart';

class FriendCard extends StatelessWidget {
  FriendCard({
    super.key,
    required this.model, required this.otherOptions,
  });

  final bool otherOptions;

  FriendController friendController = Get.put(FriendController());

  RxString character = 'Spam'.obs;

  final FriendModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          RoundCornerNetworkImage(
            imageUrl: getFormatedProfileUrl(model.user_id?.profile_pic ?? ''),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${model.user_id?.first_name ?? ''} ${model.user_id?.last_name ?? ''}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text('No mutual friend')
                ],
              ),
            ),
          ),


          otherOptions==true?
          PopupMenuButton(
              color: Colors.white,
              offset: const Offset(-50, 30),
              iconColor: Colors.black,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Get.dialog(AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: Container(
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 200,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Unfriend A Friend',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        const Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Are you sure, you want to unfriend?',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        PRIMARY_COLOR,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        PRIMARY_COLOR,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    friendController
                                                        .unfriendFriends(
                                                            '${model.id}');
                                                    Get.back();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                      value: 1,
                      // row has two child icon and text.
                      child: const Text(
                        'Unfriend',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Get.dialog(AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: Container(
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 200,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Block A Friend',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        const Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Are you sure, you want to block?',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        PRIMARY_COLOR,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        PRIMARY_COLOR,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    if (LoginCredential()
                                                            .getUserData()
                                                            .id ==
                                                        model.user_id?.id) {
                                                      friendController.blockFriends(
                                                          '${model.connected_user_id?.id}');
                                                    } else if (LoginCredential()
                                                            .getUserData()
                                                            .id ==
                                                        model.connected_user_id
                                                            ?.id) {
                                                      friendController.blockFriends(
                                                          '${model.user_id?.id}');
                                                    }

                                                    Get.back();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));

////////////////////////////////////////////////////////////////////////////////
                      },
                      value: 1,
                      // row has two child icon and text.
                      child: const Text(
                        'Block',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Get.bottomSheet(
                          SizedBox(
                            height: Get.height / 1.8,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    'Report',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: [
                                      Obx(() => ListTile(
                                            title: const Text('Spam'),
                                            subtitle: const Text(
                                                'It’s spam or violent'),
                                            leading: Radio<String>(
                                              value: 'Spam',
                                              groupValue: character.value,
                                              onChanged: (String? value) {
                                                character.value = value!;
                                                // setState(() {
                                                //   _character = value;
                                                // });
                                              },
                                            ),
                                          )),
                                      Obx(() => ListTile(
                                            title:
                                                const Text('False information'),
                                            subtitle: const Text(
                                                'If someone is in immediate danger'),
                                            leading: Radio<String>(
                                              value: 'False information',
                                              groupValue: character.value,
                                              onChanged: (String? value) {
                                                character.value = value!;
                                                // setState(() {
                                                //   _character = value;
                                                // });
                                              },
                                            ),
                                          )),
                                      Obx(() => ListTile(
                                            title: const Text('Nudity'),
                                            subtitle: const Text(
                                                'It’s Sexual activity or nudity showing genitals'),
                                            leading: Radio<String>(
                                              value: 'Nudity',
                                              groupValue: character.value,
                                              onChanged: (String? value) {
                                                character.value = value!;
                                                // setState(() {
                                                //   _character = value;
                                                // });
                                              },
                                            ),
                                          )),
                                      Obx(() => ListTile(
                                            title: const Text('Harassment'),
                                            subtitle: const Text(
                                                'If any post harassment for you and your friend'),
                                            leading: Radio<String>(
                                              value: 'Harassment',
                                              groupValue: character.value,
                                              onChanged: (String? value) {
                                                character.value = value!;
                                                // setState(() {
                                                //   _character = value;
                                                // });
                                              },
                                            ),
                                          )),
                                      Obx(() => ListTile(
                                            title: const Text('Something Else'),
                                            subtitle: const Text(
                                                'Fraud, scam, violence, hate speech etc. '),
                                            leading: Radio<String>(
                                              value: 'Something Else',
                                              groupValue: character.value,
                                              onChanged: (String? value) {
                                                character.value = value!;
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
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: Get.width / 2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1)),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Get.back();

                                        Get.bottomSheet(
                                          SizedBox(
                                            height: Get.height / 1.8,
                                            width: Get.width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: const Text(
                                                    'Report',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: Text(
                                                        'Description',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: Get.height / 2.9,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: const TextField(
                                                        maxLines: 8,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        width: Get.width / 2,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 1)),
                                                        child: const Text(
                                                          'Back',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        width: Get.width / 2,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                          color: PRIMARY_COLOR
                                                              .withOpacity(0.7),
                                                        ),
                                                        child: const Text(
                                                          'Report',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          color: PRIMARY_COLOR.withOpacity(0.7),
                                        ),
                                        width: Get.width / 2,
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
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
                      },

                      value: 1,
                      // row has two child icon and text.
                      child: const Text(
                        'Report',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ])
              :PopupMenuButton(
              color: Colors.white,
              offset: const Offset(-50, 30),
              iconColor: Colors.black,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [

                PopupMenuItem(
                  onTap: () {
                    Get.bottomSheet(
                      SizedBox(
                        height: Get.height / 1.8,
                        child: Column(
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Report',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                children: [
                                  Obx(() => ListTile(
                                    title: const Text('Spam'),
                                    subtitle: const Text(
                                        'It’s spam or violent'),
                                    leading: Radio<String>(
                                      value: 'Spam',
                                      groupValue: character.value,
                                      onChanged: (String? value) {
                                        character.value = value!;
                                        // setState(() {
                                        //   _character = value;
                                        // });
                                      },
                                    ),
                                  )),
                                  Obx(() => ListTile(
                                    title:
                                    const Text('False information'),
                                    subtitle: const Text(
                                        'If someone is in immediate danger'),
                                    leading: Radio<String>(
                                      value: 'False information',
                                      groupValue: character.value,
                                      onChanged: (String? value) {
                                        character.value = value!;
                                        // setState(() {
                                        //   _character = value;
                                        // });
                                      },
                                    ),
                                  )),
                                  Obx(() => ListTile(
                                    title: const Text('Nudity'),
                                    subtitle: const Text(
                                        'It’s Sexual activity or nudity showing genitals'),
                                    leading: Radio<String>(
                                      value: 'Nudity',
                                      groupValue: character.value,
                                      onChanged: (String? value) {
                                        character.value = value!;
                                        // setState(() {
                                        //   _character = value;
                                        // });
                                      },
                                    ),
                                  )),
                                  Obx(() => ListTile(
                                    title: const Text('Harassment'),
                                    subtitle: const Text(
                                        'If any post harassment for you and your friend'),
                                    leading: Radio<String>(
                                      value: 'Harassment',
                                      groupValue: character.value,
                                      onChanged: (String? value) {
                                        character.value = value!;
                                        // setState(() {
                                        //   _character = value;
                                        // });
                                      },
                                    ),
                                  )),
                                  Obx(() => ListTile(
                                    title: const Text('Something Else'),
                                    subtitle: const Text(
                                        'Fraud, scam, violence, hate speech etc. '),
                                    leading: Radio<String>(
                                      value: 'Something Else',
                                      groupValue: character.value,
                                      onChanged: (String? value) {
                                        character.value = value!;
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
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: Get.width / 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Get.back();

                                    Get.bottomSheet(
                                      SizedBox(
                                        height: Get.height / 1.8,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 10),
                                              child: const Text(
                                                'Report',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'Description',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Container(
                                                  height: Get.height / 2.9,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                          Colors.grey)),
                                                  child: const TextField(
                                                    maxLines: 8,
                                                    decoration:
                                                    InputDecoration(
                                                        border:
                                                        InputBorder
                                                            .none),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height: 50,
                                                    width: Get.width / 2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                            Colors.grey,
                                                            width: 1)),
                                                    child: const Text(
                                                      'Back',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    alignment:
                                                    Alignment.center,
                                                    height: 50,
                                                    width: Get.width / 2,
                                                    decoration:
                                                    BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                          Colors.grey,
                                                          width: 1),
                                                      color: PRIMARY_COLOR
                                                          .withOpacity(0.7),
                                                    ),
                                                    child: const Text(
                                                      'Report',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
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
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      color: PRIMARY_COLOR.withOpacity(0.7),
                                    ),
                                    width: Get.width / 2,
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
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
                  },

                  value: 1,
                  // row has two child icon and text.
                  child: const Text(
                    'Report',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]),

          // IconButton(
          //   onPressed: () {
          //
          //
          //
          //   },
          //   icon: const Icon(
          //     Icons.more_horiz,
          //   ),
          // )
        ],
      ),
    );
  }
}
