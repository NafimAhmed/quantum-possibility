import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/image.dart';
import '../../../components/post/post_body/post_body.dart';
import '../../../components/post/post_header.dart';
import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../models/post.dart';
import '../../../utils/color.dart';
import '../../../utils/image.dart';
import '../controllers/share_post_controller.dart';

class SharePostView extends GetView<SharePostController> {
   SharePostView({Key? key,required this
   .postModel}) : super(key: key);

   final PostModel postModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Post'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: 25,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                                border: Border.all(color: PRIMARY_COLOR, width: 1),
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
                                  style: const TextStyle(color: PRIMARY_COLOR),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? value) {
                                    controller.dropdownValue.value = value!;
                                    if(value == 'Public'){
                                      controller.postPrivacy.value = 'public';
                                    }
                                    else if(value == 'Friends'){
                                      controller.postPrivacy.value = 'friends';
                                    }
                                    else {
                                      controller.postPrivacy.value = 'only_me';
                                    }
                                  },
                                  items: SharePostController.list
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: TextField(
                    controller: controller.descriptionController,
                    maxLines: 10,

                    decoration:InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText:
                      'What’s on your mind ${controller.userModel.first_name}?',
                    ),
                    onChanged: (value) {
                      debugPrint(
                          'Update model status code on chage.............${controller.descriptionController.text}');
                    },
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey
                    ),
                  ),
                  child: Column(
                    children: [
                      PostHeader(model: postModel! ,onTapEditPost: (){

                      },),
                      const SizedBox(height: 10),
                      PostBodyView(
                        model: postModel! ,
                        onTapBodyViewMoreMedia: (){

                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )




              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: Get.width,
              child: Expanded(
                child: PrimaryButton(
                  onPressed: () {  }, text: 'Share',),
              ),
            ),
          ),
        ],
      )
    );
  }


  String getFormatedPostUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/$path';
  }
}
