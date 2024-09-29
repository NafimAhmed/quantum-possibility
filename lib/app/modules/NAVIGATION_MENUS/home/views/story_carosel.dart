import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';

import '../../../../models/story.dart';
import '../../../../utils/date_time.dart';
import '../../../../utils/image.dart';

class StoryCarosel extends GetView<HomeController> {
  const StoryCarosel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CarouselSlider.builder(
      itemCount: controller.storytList.value.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        StoryModel storyModel = controller.storytList.value[itemIndex];

        UserModelId userModelId = storyModel.user_id!;

        // controller.storyViewed('${storyModel.id}');

        // return MyDayDetail(
        //   imageURL: getFormatedStoryUrl(
        //     storyModel.media ?? '',
        //   ),
        //   profileImage: getFormatedProfileUrl(userModelId.profile_pic ?? ''),
        //   userName: '${userModelId.first_name} ${userModelId.last_name}',
        //   // '${getFormatedProfileUrl(userModelId.first_name ?? ' ')} ${getFormatedProfileUrl(userModelId.last_name ?? ' ')}',
        //   createdAt: storyTimeText(storyModel),
        //   title: storyModel.title ?? '',
        //   id: storyModel.id ?? '',
        //   isProfile: storyModel.user_id?.username !=
        //           LoginCredential().getUserData().username
        //       ? false
        //       : true,
        //   viewCont: storyModel.user_id?.username !=
        //           LoginCredential().getUserData().username
        //       ? ''
        //       : '',
        //   // getFormatedStoryUrl(
        //   //   storyModel.title ?? '',
        //   // ),
        // );
        return FutureBuilder(
            future: controller.getSingleStory(storyModel.id ?? ''),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data?.stories?.length,
                  itemBuilder: (BuildContext context, int innerItemIndex,
                      int pageViewIndex) {
                    return Stack(
                      children: [
                        Image(
                          height: 800,
                          fit: BoxFit.fitHeight,
                          // fit: BoxFit.fitWidth,
                          image: NetworkImage(getFormatedStoryUrl(
                              snapshot.data?.stories?[innerItemIndex].media ??
                                  '')),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                );
              } else {
                return const Center(child: Text('Loading'));
              }
            });
      },
      options: CarouselOptions(
        // height: Get.height,
        // aspectRatio: 16 / 9,
        // onPageChanged: (index, reason) {
        //   // if(index>=controller.storytList.value.length-1){
        //   //   Get.back();
        //   // }
        // },
        // viewportFraction: 1,
        // initialPage: controller.storyCaroselInitialIndex.value,
        // enableInfiniteScroll: true,
        // reverse: false,
        // // autoPlay: controller.storytList.value.length < 2 ? false : true,
        autoPlayInterval: const Duration(seconds: 5),
        // // autoPlayAnimationDuration: const Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        // enlargeFactor: 0.3,
        // scrollDirection: Axis.horizontal,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
    ));
  }

  String storyTimeText(StoryModel storyModel) {
    DateTime postDateTime =
        DateTime.parse(storyModel.createdAt ?? '').toLocal();
    DateTime currentDatetime = DateTime.now();
    // Calculate the difference in milliseconds
    int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
        postDateTime.millisecondsSinceEpoch;
    // Convert to minutes (ignoring milliseconds)
    int minutesDifference =
        (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

    if (minutesDifference < 1) {
      return 'a few seconds ago';
    } else if (minutesDifference < 30) {
      return '$minutesDifference minutes ago';
    } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
      return 'Today at ${postTimeFormate.format(postDateTime)}';
    } else {
      return postDateTimeFormate.format(postDateTime);
    }
  }
}
