import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';

import '../models/story.dart';
import '../routes/app_pages.dart';
import '../utils/date_time.dart';
import '../utils/image.dart';
import 'image.dart';

class MyDayCard extends StatelessWidget {
  MyDayCard({
    super.key,
    required this.storyModel,
    required this.storyIndex,
  });

  final StoryModel storyModel;
  final int storyIndex;

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    UserModelId userModelId = storyModel.user_id!;
    return InkWell(
      onTap: () {
        homeController.storyCaroselInitialIndex.value = storyIndex;

        Get.toNamed(Routes.STORY_CAROSEL);
      },
      child: Stack(
        children: [
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          //   height: 116.48,
          //   width: 80.64,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image:
          //           NetworkImage(getFormatedStoryUrl(storyModel.media ?? '')),
          //     ),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: RoundCornerNetworkImage(
                height: 120,
                width: 80,
                imageUrl: getFormatedStoryUrl(storyModel.media ?? '')),
          ),
          Positioned(
            left: 35,
            top: 95,
            child: CircleAvatar(
              radius: 19,
              backgroundColor: const Color.fromARGB(255, 45, 185, 185),
              child: CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage(
                    getFormatedProfileUrl(userModelId.profile_pic ?? '')),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Text(
              userModelId.first_name ?? '',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
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
