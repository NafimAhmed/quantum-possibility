import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/single_image.dart';
import '../../../../../data/login_creadential.dart';
import '../../../../../components/comment/comment_component.dart';
import '../../../../../components/my_day_detail.dart';
import '../../../../../components/post/post.dart';
import '../../../../../components/profile_tile.dart';
import '../../../../../components/profile_view_banner_image.dart';
import '../../../../../config/app_assets.dart';
import '../../../../../models/post.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/image.dart';
import '../../../../../utils/post_utlis.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 47.86,
                  width: 47.86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        controller.userModel.profile_pic != null
                            ? getFormatedProfileUrl(
                                controller.userModel.profile_pic!)
                            : 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: controller.onTapCreatePost,
                  child: Container(
                    height: 40,
                    width: Get.width - 140,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                            0.1), //Color.fromARGB(135, 238, 238, 238),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "What's on your mind, ${controller.userModel.first_name}?",
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_library_outlined)),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.isLoadingNewsFeed.value == true
                  ? Container(
                      height: 40,
                      width: Get.width,
                      color: Colors.white,
                      child: Image.asset(
                        'assets/other/loading_profile.gif',
                        height: 40,
                        width: Get.width,
                      ))
                  : ListView.builder(
                      // physics:
                      //     const NeverScrollableScrollPhysics(),
                      controller: controller.listScrollController,
                      //physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.postList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        PostModel model = controller.postList.value[index];
                        return PostCard(
                          index: index,
                          model: model,
                          onSelectReaction: (reaction) {
                            controller.reactOnPost(
                              postModel: model,
                              reaction: reaction,
                              index: index,
                            );
                          },
                          onPressedComment: () {
                            Get.bottomSheet(
                              Obx(
                                () => CommentComponent(
                                  commentController:
                                      controller.commentController,
                                  postModel: controller.postList.value[index],
                                  userModel: controller.userModel,
                                  onTapSendComment: () {
                                    controller.commentOnPost(index, model);
                                  },
                                  onTapReplayComment: (
                                      {required commentReplay,
                                      required comment_id}) {},
                                  onSelectCommentReaction: (reaction) {},
                                  onSelectCommentReplayReaction: (reaction) {},
                                  onTapViewReactions: () {
                                    Get.toNamed(Routes.REACTIONS,
                                        arguments: model.id);
                                  },
                                ),
                              ),
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                            );
                          },
                          onPressedShare: () {},
                          onTapBodyViewMoreMedia: () {},
                          onTapViewReactions: () {
                            Get.toNamed(Routes.REACTIONS, arguments: model.id);
                          },
                          onTapEditPost: (){
                            Get.back();
                            controller.onTapEditPost(model);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            const Text(
              'All Photos',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PRIMARY_COLOR),
            ),
            Obx(() => GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.photoList.value
                      .length, //controller.photoModel.value?.posts?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(SingleImage(
                          imgURL: getFormatedPostUrl(
                              '${controller.photoList.value[index].media}'),
                        ));
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
                          width: Get.width / 3,
                          height: 157,
                          fit: BoxFit.cover,
                          image: NetworkImage(getFormatedPostUrl(
                              '${controller.photoList.value[index].media}')),
                          placeholder: const AssetImage(
                              'assets/image/default_image.png'),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            // Text('All Photos',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: PRIMARY_COLOR),),

            Obx(() => GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.storyList.value
                      .length, //controller.photoModel.value?.posts?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      crossAxisCount: 3,
                      childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          MyDayDetail(
                            imageURL: getFormatedStoryUrl(
                                '${controller.storyList.value[index].media}'),
                            profileImage: getFormatedProfileUrl(
                                '${LoginCredential().getUserData().profile_pic}'),
                            userName:
                                '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                            createdAt: getDynamicFormatedCommentTime(
                                '${controller.storyList.value[index].createdAt}'),
                            title: getFormatedStoryUrl(
                                '${controller.storyList.value[index].title}'),
                            id: '${controller.storyList.value[index].id}',
                            isProfile: true,
                            viewCont:
                                '${controller.storyList.value[index].viewersCount}',
                          ),
                        );

                        // Get.to(SingleImage(imgURL: '${getFormatedPostUrl('${controller.photoList.value[index].media}')}',));
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Image(
                                    height: 400,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      AppAssets.DEFAULT_IMAGE,
                                    ),
                                  );
                                },
                                width: Get.width / 3,
                                height: 157,
                                fit: BoxFit.cover,
                                image: NetworkImage(getFormatedStoryUrl(
                                    '${controller.storyList.value[index].media}')),
                                placeholder: const AssetImage(
                                    'assets/image/default_image.png'),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 6,
                            child: SizedBox(
                              width: 60,
                              child: Text(
                                getDynamicFormatedCommentTime(
                                    '${controller.storyList.value[index].createdAt}'),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    ];

    controller.postList.value.length;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.getPosts,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: controller
                .postScrollController, //controller.mainPageScrollController,
            child: Column(
              children: [
                Obx(
                  () => controller.isLoadingRefresh.value == true
                      ? const CircularProgressIndicator()
                      : PrifileViewBannerImage(
                          profileImageUpload: () {
                            controller.profilePicUpload();
                          },
                          coverImageUpload: () {
                            controller.coverPicUpload();
                          },
                          banner: controller.profileModel.value?.cover_pic !=
                                  null
                              ? getFormatedProfileUrl(
                                  '${controller.profileModel.value?.cover_pic}')
                              : 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
                          //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                          profilePic: controller
                                      .profileModel.value?.profile_pic !=
                                  null
                              ? getFormatedProfileUrl(
                                  '${controller.profileModel.value?.profile_pic}')
                              : 'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
                          //'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                          enableImageUpload: true,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: Get.width * 0.34,
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Add to story',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 35,
                      width: Get.width * 0.34,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(color: PRIMARY_COLOR),
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(),
                //====================================================================== Profile Info ======================================================================//

                Obx(
                  () => (controller.profileModel.value != null &&
                          controller
                              .profileModel.value!.userWorkplaces.isNotEmpty)
                      ? ProfileTile(
                          company: controller.profileModel.value?.userWorkplaces
                                  .first.org_name ??
                              '',
                          designetion:
                              '${controller.profileModel.value?.userWorkplaces.first.designation ?? 'Work'} at ', //'Founder and CEO at ',
                          icon: const Icon(Icons.business_center),
                        )
                      : Container(),
                ),
                Obx(
                  () => (controller.profileModel.value != null &&
                          controller.profileModel.value!.educationWorkplaces
                              .isNotEmpty)
                      ? ProfileTile(
                          company: controller.profileModel.value
                                  ?.educationWorkplaces.first.institute_name ??
                              '',
                          designetion:
                              '${controller.profileModel.value?.educationWorkplaces.first.designation ?? 'Studied'} at ', //'Founder and CEO at ',
                          icon: const Icon(Icons.school),
                        )
                      : Container(),
                ),

                Obx(
                  () => Visibility(
                    visible: controller.profileModel.value?.present_town != null
                        ? true
                        : false,
                    child: ProfileTile(
                      company: '${controller.profileModel.value?.present_town}',
                      designetion: 'Lives in ',
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
                        child: const ProfileTile(
                          company: '',
                          designetion: 'See your about info.',
                          icon: Icon(Icons.more_horiz),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.ABOUT);
                        },
                      )
                    : Container()),

                Container(
                  height: 35,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit public details',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                const Divider(),
                //====================================================================== Tab Bar ======================================================================//

                const SizedBox(
                  height: 7,
                ),

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
                              'Your Feed',
                              style: TextStyle(
                                color: controller.viewNumber.value == 0
                                    ? PRIMARY_COLOR
                                    : Colors.black,
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.viewNumber.value = 1;
                        controller.getPhotos();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Obx(
                          () => Text(
                            'Photos',
                            style: TextStyle(
                              color: controller.viewNumber.value == 1
                                  ? PRIMARY_COLOR
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.viewNumber.value = 2;
                        controller.getStoris();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Obx(
                          () => Text(
                            'Stories',
                            style: TextStyle(
                              color: controller.viewNumber.value == 2
                                  ? PRIMARY_COLOR
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        Get.toNamed(Routes.OTHER_FRIEND_LIST,arguments: '${LoginCredential().getUserData().username}');
                        //Get.toNamed(Routes.PROFILE_FRIEND_LIST);
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
            ),
          ),
        ),
      ),
    );
  }
}
