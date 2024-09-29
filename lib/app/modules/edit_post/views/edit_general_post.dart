import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/models/user_id.dart';
import '../../../models/MediaTypeModel.dart';
import '../../../components/image.dart';
import '../../../config/api_constant.dart';
import '../../../config/app_assets.dart';
import '../../../data/login_creadential.dart';
import '../../../models/feeling_model.dart';
import '../../../models/friend.dart';
import '../../../models/location_model.dart';
import '../../../models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../../../utils/image.dart';
import '../../../utils/post_type.dart';
import '../controllers/edit_post_controller.dart';
import 'edit_check_in.dart';
import 'edit_feeling.dart';
import 'edit_tag_people.dart';

class EditGeneralPostView extends GetView<EditPostController> {
   EditGeneralPostView({Key? key, required this.postModel})
      : super(key: key);

  final PostModel? postModel;

  // final EditPostController controller =  Get.put(EditPostController());

  @override
  Widget build(BuildContext context) {


    updateLocalData();



    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: const Text(
                'Edit Post',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                await controller.updateUserPost();
              },
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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

                                            WidgetSpan(child:  Padding(
                                              padding: const EdgeInsets.only(left: 3.0),
                                              child: ReactionIcon(controller.feelingName.value!.logo.toString()

                                              ),
                                            ) ),
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

                                    ]
                                ):

                                     TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                                controller.locationName.value?.locationName != null
                                   ?
                                TextSpan(
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
                                    :
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                                    controller.checkFriendList.value.length == 1
                                    ?
                                    TextSpan(
                                    children: [
                                      TextSpan(
                                          text: ' with',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 16)),
                                      TextSpan(
                                          text:
                                          ' ${controller.checkFriendList.value[0]!.username.toString()}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16))
                                    : controller.checkFriendList.value.length > 1
                                    ?
                                    TextSpan(
                                    children: [
                                      TextSpan(
                                          text: ' with',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 16)),
                                      TextSpan(
                                          text:
                                          ' ${controller.checkFriendList.value[0]!.username.toString()} and ${controller.checkFriendList.value.length - 1} others',
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
                                    controller.postPrivacy.value = value!;
                                  },
                                  items: EditPostController.list
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
              TextField(
                controller: controller.descriptionController,
                maxLines: 10,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  debugPrint(
                      'Update model status code on chage.............${controller.descriptionController.text}');
                },
              ),
             Container(
                    // width: Get.width,
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    child:
                       Obx(() =>
                           controller.isLoading.value == true ?
                               const Center(child: CircularProgressIndicator(),) :
                           ListView.builder(
                             shrinkWrap: true,
                             scrollDirection: Axis.horizontal,
                             itemCount: controller.imageFromNetwork.value.length,
                             itemBuilder: (BuildContext context, int index) {
                               debugPrint("length from view ....."+controller.imageFromNetwork.value.length.toString());

                               return
                                 controller.imageFromNetwork.value[index].isFile == true ?
                                 Stack(
                                   children: [
                                     Image(
                                         height: 120,
                                         width: 100,
                                         image: FileImage(File(controller.imageFromNetwork.value[index].imagePath.toString()))
                                     ),
                                     Positioned(
                                       right: 0,
                                       top: 20,
                                       child: InkWell(
                                         onTap: () {
                                          controller.imageFromNetwork.value.removeAt(index);
                                          controller.xfiles.value.removeAt(index);
                                          controller.imageFromNetwork
                                              .refresh();
                                          debugPrint("length from delete ....."+controller.imageFromNetwork.value.length.toString());
                                         },
                                         child: Icon(
                                           Icons.cancel_rounded,
                                           size: 20,
                                           color: Colors.black.withOpacity(0.5),
                                         ),
                                       ),
                                     )
                                   ],
                                 )
                                     :
                                 Stack(
                                   children: [
                                     Image.network(
                                       controller.imageFromNetwork.value[index].imagePath.toString(),
                                       height: 120,
                                       width: 100,
                                       errorBuilder: (context, error, stackTrace) {
                                         return const Image(
                                           height: 120,
                                           width: 100,
                                           image: AssetImage(AppAssets.DEFAULT_IMAGE),
                                         );
                                       },
                                     ),
                                      Positioned(
                                       right: 0,
                                       top: 20,
                                       child: InkWell(
                                         onTap: () {
                                           controller.removeMediaId.value.add(
                                               controller.imageFromNetwork.value[index].mediaId.toString()
                                           );
                                           controller.imageFromNetwork.value.removeAt(index);
                                           controller.imageFromNetwork
                                               .refresh();
                                           debugPrint("length from delete ....."+controller.removeMediaId.value[0].toString());
                                         },
                                         child: Container(
                                           height: 18,
                                           width: 18,
                                           decoration: BoxDecoration(
                                             color: Colors.white,
                                             shape: BoxShape.circle,
                               ),
                                           child: Icon(
                                             Icons.cancel_rounded,
                                             size: 20,
                                             color: Colors.black.withOpacity(0.5),
                                           ),
                                         ),
                                       ),
                                     )
                                   ],
                                 )
                               ;
                             },

                           )
                       )
                  ),

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
                                      '${controller.imageFromNetwork.value.length} Added ',
                                      style: const TextStyle(fontSize: 16),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {

                              controller.checkFriendList.value =
                                  await Get.to(() => EditTagPeople());

                              debugPrint(controller.checkFriendList.value.toString());
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
                                  await Get.to(() => EditFeeling()) as PostFeeling;

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
                                  await Get.to(() => EditCheckIn()) as AllLocation;

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
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getFormatedPostUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/uploads/posts/$path';
  }


  void updateLocalData(){
    controller.descriptionController.clear();
    controller.imageFromNetwork.value.clear();
    controller.removeMediaId.value.clear();
    debugPrint(
        'Update model status code 111.............${controller.descriptionController.text}');
    debugPrint(
        'Update model status code 111.............${postModel!.description}');


    controller.descriptionController.text = postModel!.description.toString();
    controller.userId.value = postModel!.user_id!.id.toString();
    controller.postId.value = postModel!.id.toString();
    controller.dropdownValue.value =  postModel!.post_privacy.toString();
    controller.postPrivacy.value = postModel!.post_privacy.toString();



    if (postModel!.media!.isNotEmpty) {
      for (int index = 0; index < postModel!.media!.length; index++) {
        controller.imageFromNetwork.value
            .add( MediaTypeModel(imagePath:getFormatedPostUrl(postModel!.media![index].media.toString()), isFile: false,
            mediaId: postModel!.media![index].id.toString()
        )
        );
      }
    }


   if(postModel!.location_id != null) {
      controller.locationName.value =
          AllLocation(
              city: '', lat: "", lng: "", country: "", countryCode: '',
              id: '', locationName: postModel!.location_id!.locationName, image: "", subAddress: "");


      controller.locationId.value = postModel!.location_id!.id.toString();

      debugPrint("edit location id ..............."+controller.locationId.value);
      debugPrint("edit location name ..............."+controller.locationName.value!.locationName.toString());
    }


   if(postModel!.feeling_id != null) {
      controller.feelingName.value =

          PostFeeling(id: postModel!.feeling_id!.id.toString(),
              feelingName: postModel!.feeling_id!.feelingName.toString(),
              logo: postModel!.feeling_id!.logo.toString());

      controller.feelingId.value = postModel!.feeling_id!.id.toString();

      debugPrint("edit feeling id ..............."+controller.feelingId.value);
    }

   if(postModel!.taggedUserList!.isNotEmpty){
       for(int index = 0 ; index < postModel!.taggedUserList!.length ; index++){
         controller.checkFriendList.value.add(
           postModel!.taggedUserList![index].user as User

         );
       }
   }












  }

   Widget ReactionIcon(String reactionPath) {
     return Image(height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath)));
   }

   String getFormatedFeelingUrl(String path) {
     return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
   }
}
