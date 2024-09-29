import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quantum_possibilities_flutter/app/modules/other_profile_view/controller/other_profile_controller.dart';
import 'package:quantum_possibilities_flutter/app/utils/post_utlis.dart';
import '../../../components/comment/comment_component.dart';
import '../../../components/my_day_detail.dart';
import '../../../components/post/post.dart';
import '../../../components/profile_tile.dart';
import '../../../components/profile_view_banner_image.dart';
import '../../../components/single_image.dart';
import '../../../config/app_assets.dart';
import '../../../models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../../../utils/image.dart';
import '../../shared/multiple_image/views/multiple_image_view.dart';

class OtherProfileView extends GetView<OtherProfileView> {
  const OtherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    OthersProfileController controller = Get.put(OthersProfileController());

    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoadingNewsFeed.value!=true? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.postList.value.length,
                itemBuilder: (context, index) {
                  PostModel postModel = controller.postList.value[index];

                  return PostCard(
                    model: postModel,
                    onSelectReaction: (reaction) {
                      // controller.reactOnPost(
                      //   postModel: postModel,
                      //   reaction: reaction,
                      //   index: index,
                      // );
                      // debugPrint(reaction);
                    },
                    onPressedComment: () {
                      Get.bottomSheet(
                        Obx(
                          () => CommentComponent(
                            commentController: controller.commentController,
                            postModel: controller.postList.value[index],
                            userModel: controller.userModel,
                            onTapSendComment: () {
                              controller.commentOnPost(index, postModel);
                            },
                            onTapReplayComment: (
                                {required commentReplay,
                                required comment_id}) {},
                            onSelectCommentReaction: (reaction) {},
                            onSelectCommentReplayReaction: (reaction) {},
                            onTapViewReactions: () {
                              Get.toNamed(Routes.REACTIONS,
                                  arguments: postModel.id);
                            },
                          ),
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                      );
                    },
                    onPressedShare: () {},
                    onTapBodyViewMoreMedia: () {
                      Get.to(MultipleImageView(postModel: postModel));
                    },
                    onTapViewReactions: () {
                      Get.toNamed(Routes.REACTIONS, arguments: postModel.id);
                    },
                  );
                },
              ):
              Container(
                  height: 40,
                  width: Get.width,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/other/loading_profile.gif',
                    height: 40,
                    width: Get.width,
                  ),),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [

            Text('All Photos',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: PRIMARY_COLOR),),


            Obx(() => GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.photoList.value.length,//controller.photoModel.value?.posts?.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio:0.7),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Get.to(SingleImage(imgURL: '${getFormatedPostUrl('${controller.photoList.value[index].media}')}',));
                  },
                  child: Padding(

                    padding: const EdgeInsets.all(3.0),
                    child: FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AppAssets.DEFAULT_IMAGE,

                          ),
                        );
                      },
                      width: Get.width/3,
                      height: 157,
                      fit: BoxFit.cover,
                      image: NetworkImage(getFormatedPostUrl('${controller.photoList.value[index].media}')),
                      placeholder: AssetImage('assets/image/default_image.png'),

                    ),
                  ),
                );
              },)),






          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [

            // Text('All Photos',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: PRIMARY_COLOR),),


            Obx(() => GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.storyList.value.length,//controller.photoModel.value?.posts?.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  crossAxisCount: 3,
                  childAspectRatio:0.7
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){

                    Get.to(
                      MyDayDetail(
                        imageURL: '${getFormatedStoryUrl('${controller.storyList.value[index].media}')}',
                        profileImage: '${getFormatedProfileUrl('${controller.profileModel.value?.profile_pic}')}',
                        userName: '${controller.profileModel.value?.first_name} ${controller.profileModel.value?.last_name}',
                        createdAt: '${getDynamicFormatedCommentTime('${controller.storyList.value[index].createdAt}')}',
                        title: '${getFormatedStoryUrl('${controller.storyList.value[index].title}')}', id: '${controller.storyList.value[index].id}',
                        isProfile: true, viewCont: '${controller.storyList.value[index].viewersCount}',
                      ),
                    );

                    // Get.to(SingleImage(imgURL: '${getFormatedPostUrl('${controller.photoList.value[index].media}')}',));
                  },
                  child:

                  Stack(
                    children: [

                      Padding(

                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Image(
                                height: 400,
                                fit: BoxFit.cover,
                                image: AssetImage(AppAssets.DEFAULT_IMAGE),
                              );
                            },
                            width: Get.width/3,
                            height: 157,
                            fit: BoxFit.cover,
                            image: NetworkImage(getFormatedStoryUrl('${controller.storyList.value[index].media}')),
                            placeholder: AssetImage('assets/image/default_image.png'),

                          ),
                        ),
                      ),
                      Positioned(

                        child: Container(
                          child: Text(
                            '${getDynamicFormatedCommentTime('${controller.storyList.value[index].createdAt}')}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          width: 60,
                        ),

                        top: 4,
                        left: 6,
                      ),
                    ],
                  ),
                );
              },)),






          ],
        ),
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ////////////////////////////////////////////////////////////////////////////////

                Obx(
                  () =>
                      // controller.isLoadingRefresh.value == true
                      // ? const CircularProgressIndicator() :
                      PrifileViewBannerImage(
                    profileImageUpload: () {
                      //controller.profilePicUpload();
                    },
                    coverImageUpload: () {
                      //controller.coverPicUpload();
                    },
                    banner: controller.profileModel.value?.cover_pic != null
                        ? getFormatedProfileUrl(
                            '${controller.profileModel.value?.cover_pic}')
                        : 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
                    //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                    profilePic: controller.profileModel.value?.profile_pic !=
                            null
                        ? getFormatedProfileUrl(
                            '${controller.profileModel.value?.profile_pic}')
                        : 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
                    //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                    enableImageUpload: false,
                  ),
                ),

                Obx(() => Text(
                      '${controller.profileModel.value?.first_name ?? ''} ${controller.profileModel.value?.last_name ?? ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    )),

                const SizedBox(
                  height: 10,
                ),

                const Divider(),

                //====================================================================== Profile Info ======================================================================//

                (controller.profileModel.value?.userWorkplaces != null &&
                        controller
                            .profileModel.value!.userWorkplaces.isNotEmpty)
                    ? ProfileTile(
                        company: controller.profileModel.value?.userWorkplaces
                                .first.org_name ??
                            '',
                        designetion:
                            '${controller.profileModel.value?.userWorkplaces.first.designation ?? 'Works'} at ', //'Founder and CEO at ',
                        icon: const Icon(Icons.business_center),
                      )
                    : Container(),

                (controller.profileModel.value?.educationWorkplaces != null &&
                        controller
                            .profileModel.value!.educationWorkplaces.isNotEmpty)
                    ? ProfileTile(
                        company: controller.profileModel.value
                                ?.educationWorkplaces.first.institute_name ??
                            '',
                        designetion:
                            '${controller.profileModel.value?.educationWorkplaces.first.designation ?? 'Studied'} at ', //'Founder and CEO at ',
                        icon: const Icon(Icons.school),
                      )
                    : Container(),

                Obx(
                  () => Visibility(
                    visible: controller.profileModel.value?.present_town != null
                        ? true
                        : false,
                    child: ProfileTile(
                      company: '${controller.profileModel.value?.present_town}',
                      // controller.userModel.present_town != null
                      //     ? '${controller.userModel.present_town}'
                      //     : 'No living place',
                      designetion: //controller.userModel.present_town != null?
                          'Lives in ',
                      // : '',
                      icon: const Icon(Icons.home),
                    ),
                  ),
                ),

                Obx(
                  () => Visibility(
                    visible: controller.profileModel.value?.home_town != null
                        ? true
                        : false,
                    child: ProfileTile(
                      company: '${controller.profileModel.value?.home_town}',
                      designetion:
                          controller.userModel.home_town == null ? '' : 'From ',
                      icon: const Icon(Icons.location_on),
                    ),
                  ),
                ),

                Obx(() => controller.profileModel.value != null
                    ? InkWell(
                        onTap: () {
                          Get.toNamed(Routes.OTHER_PROFILA_DETAIL);
                        },
                        child: const ProfileTile(
                          company: '',
                          designetion: 'See your about info.',
                          icon: Icon(Icons.more_horiz),
                        ),
                      )
                    : Container()),

                const Divider(),
                //====================================================================== Tab Bar ======================================================================//

                //=============================================================== Tab Bar ======================================================================================

                const SizedBox(
                  height: 7,
                ),

                Visibility(
                  visible: '${controller.userModel.lock_profile}' == '1'
                      ? false
                      : true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.viewNumber.value = 0;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Obx(() => Text(
                                'Feed',
                                style: TextStyle(
                                  color: controller.viewNumber.value == 0?PRIMARY_COLOR:Colors.black,
                                ),
                              ),),


                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.viewNumber.value = 1;
                              controller.getOtherPhotos();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child:  Obx(() => Text(
                                'Photos',
                                style: TextStyle(
                                  color: controller.viewNumber.value == 1?PRIMARY_COLOR:Colors.black,
                                ),
                              ),),


                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.viewNumber.value = 2;
                              controller.getOtherStoris();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Obx(() => Text(
                                'Stories',
                                style: TextStyle(
                                  color: controller.viewNumber.value == 2?PRIMARY_COLOR:Colors.black,
                                ),
                              ),),
                            ),
                          ),


                          InkWell(
                            onTap: () {

                              Get.toNamed(Routes.OTHER_FRIEND_LIST,arguments: '${controller.username}');
                              //controller.viewNumber.value = 2;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                'Friends',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),




                        ],
                      ),
                      const Divider(),
                      Obx(() => widgetList[controller.viewNumber.value]),
                    ],
                  ), //false
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
