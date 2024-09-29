import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/date_time.dart';
import '../../single_image.dart';
import '../media_grid/media_grid.dart';
import '../../../models/media.dart';
import '../../../utils/post_utlis.dart';

import '../../../models/post.dart';
import '../../../utils/image.dart';
import '../../button.dart';
import '../../image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'page_post.dart';

class PostBodyView extends StatelessWidget {
  const PostBodyView({
    super.key,
    required this.model,
    required this.onTapBodyViewMoreMedia,
  });
  final PostModel model;
  final VoidCallback onTapBodyViewMoreMedia;

  @override
  Widget build(BuildContext context) {
    switch (model.post_type) {
      case 'timeline_post':
        return TimelinePost(
            postModel: model, onTapViewMoreMedia: onTapBodyViewMoreMedia);
      case 'page_post':
        return PagePost(postModel: model);
      case 'profile_picture':
        return ProfilePicturePost(postModel: model);
      case 'cover_picture':
        return CoverPicturePost(postModel: model);
      case 'event':
        return EventPost(postModel: model);
      case 'shared_reels':
        return SharedReelsPost(postModel: model);
      case 'birthday':
        return BirthdayPost(postModel: model);
      case 'campaign':
        return CampainPost(postModel: model);
      case 'Shared':
        return SharedPost(
          postModel: model,
          onTapViewMoreMedia: onTapBodyViewMoreMedia,
        );
      default:
        return Container();
    }
  }
}

//=============================================================== TimeLine Post

class TimelinePost extends StatelessWidget {
  const TimelinePost({
    super.key,
    required this.postModel,
    required this.onTapViewMoreMedia,
  });

  final PostModel postModel;
  final VoidCallback onTapViewMoreMedia;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    for (MediaModel media in postModel.media ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }

    return postModel.event_type.toString().length > 1
        ?
        //======================================================== Showing Event Post ========================================================//
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  postModel.event_type == 'education'
                      ? Image.asset(
                          'assets/icon/live_event/education_event_icon.png',
                          width: 100,
                          height: 100,
                        )
                      : Image.asset(
                          'assets/icon/live_event/work_event_icon.png',
                          width: 100,
                          height: 100,
                        ),
                ],
              ),
              postModel.event_type == 'education'
                  ? Text(
                      textAlign: TextAlign.center,
                      postModel.event_sub_type!.contains('New School')
                          ? 'Started School at ${postModel.institute_id!.instituteName}'
                          : postModel.event_sub_type!.contains('Graduate')
                              ? 'Graduated from ${postModel.institute_id!.instituteName}'
                              : 'Left School from ${postModel.institute_id!.instituteName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      textAlign: TextAlign.center,
                      postModel.event_sub_type!.contains('New Job')
                          ? 'Started New Job at ${postModel.workplace_id!.orgName}'
                          : postModel.event_sub_type!.contains('Promotion')
                              ? 'Promoted Job at ${postModel.workplace_id!.orgName}'
                              : postModel.event_sub_type!.contains('Left Job')
                                  ? 'Left Job from ${postModel.workplace_id!.orgName}'
                                  : 'Retirement from ${postModel.workplace_id!.orgName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 3,
              ),
              postModel.event_type == 'education'
                  ? Text(
                      postModel.event_sub_type!.contains('New School')
                          ? getDynamicFormatedTime(
                              postModel.institute_id!.startDate.toString())
                          : postModel.event_sub_type!.contains('Graduate')
                              ? getDynamicFormatedTime(
                                  postModel.institute_id!.endDate.toString())
                              : getDynamicFormatedTime(
                                  postModel.institute_id!.endDate.toString()),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      ),
                    )
                  : Text(
                      postModel.event_sub_type!.contains('New Job')
                          ? getDynamicFormatedTime(
                              postModel.workplace_id!.fromDate.toString())
                          : postModel.event_sub_type!.contains('Promotion')
                              ? getDynamicFormatedTime(
                                  postModel.workplace_id!.fromDate.toString())
                              : postModel.event_sub_type!.contains('Left Job')
                                  ? getDynamicFormatedTime(
                                      postModel.workplace_id!.toDate.toString())
                                  : getDynamicFormatedTime(postModel
                                      .workplace_id!.toDate
                                      .toString()),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      )),
            ],
          )
        : postModel.link_image == null || postModel.link_image == ''
            //======================================================== Showing Image with Description Post ========================================================//

            ? ((postModel.media?.length ?? 0) > 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(postModel.description ?? ''),
                      ),
                      ((postModel.media?.length ?? 0) > 0)
                          ? SizedBox(
                              height: 500,
                              child: MediaGridView(
                                  mediaUrls: imageUrls,
                                  onTapViewMoreMedia: onTapViewMoreMedia),
                            )
                          : PrimaryNetworkImage(imageUrl: imageUrls[0]),
                    ],
                  )
                : ((postModel.media?.length ?? 0) == 0)
                    ? Container(
                        // =================================================== No Meida Post ===================================================
                        height: (postModel.post_background_color != null &&
                                postModel.post_background_color!.isNotEmpty &&
                                postModel.post_background_color! != '')
                            ? 256
                            : null, // not having background color will make height dynamic
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: (postModel.post_background_color != null &&
                                    postModel.post_background_color!.isNotEmpty)
                                ? Color(int.parse(
                                    '0xff${postModel.post_background_color}'))
                                : null),
                        padding: const EdgeInsets.all(10),
                        child: (postModel.post_background_color != null &&
                                postModel.post_background_color != '')
                            ? Center(
                                child: Text(
                                  '${postModel.description}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )
                            : ExpandableText(
                                '${postModel.description}',
                                expandText: 'See more',
                                maxLines: 5,
                                collapseText: 'see less',
                                style: const TextStyle(color: Colors.black),
                              ),
                      )
                    : Column(
                        //======================================================== Showing Link Post ========================================================//
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: RichText(
                                text: TextSpan(
                                    children: getTextWithLink(
                                        postModel.description ?? ''))),
                          ),
                          GestureDetector(
                              onTap: () async {
                                String url = postModel.link.toString();
                                await launchUrl(Uri.parse(url));
                              },
                              child: PrimaryNetworkImage(
                                  imageUrl: postModel.link_image!)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  postModel.link_title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(postModel.link_description ?? ''),
                              ],
                            ),
                          )
                        ],
                      )
            : Column(
                //======================================================== Showing Link Post ========================================================//
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: LinkText(text: postModel.description ?? '')),
                  GestureDetector(
                      onTap: () async {
                        String url = postModel.link.toString();
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      },
                      child:
                          PrimaryNetworkImage(imageUrl: postModel.link_image!)),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          postModel.link_title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(postModel.link_description ?? ''),
                      ],
                    ),
                  )
                ],
              );
  }
}

//=============================================================== Page Post

//=============================================================== Profile Picture Post

class ProfilePicturePost extends StatelessWidget {
  const ProfilePicturePost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleImage(
            imgURL: getFormatedPostUrl(postModel.media?[0].media ?? '')));
      },
      child: NetworkCircleAvatar(
        radius: 128,
        imageUrl: getFormatedPostUrl(postModel.media?[0].media ?? ''),
      ),
    );
  }
}

//=============================================================== Cover Photo Post

class CoverPicturePost extends StatelessWidget {
  const CoverPicturePost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleImage(
            imgURL: getFormatedPostUrl(postModel.media?[0].media ?? '')));
      },
      child: PrimaryNetworkImage(
        imageUrl: getFormatedPostUrl(postModel.media?[0].media ?? ''),
      ),
    );
  }
}

//=============================================================== Shared Post

class SharedPost extends StatelessWidget {
  const SharedPost({
    super.key,
    required this.postModel,
    required this.onTapViewMoreMedia,
  });

  final PostModel postModel;
  final VoidCallback onTapViewMoreMedia;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    for (MediaModel media in postModel.shareMedia ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }

    debugPrint('share value ........${postModel.share_post_id!.event_type}');

    return postModel.share_post_id!.event_type != null &&
            postModel.share_post_id!.event_type != ''
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  postModel.share_post_id!.event_type == 'education'
                      ? Image.asset(
                          'assets/icon/live_event/education_event_icon.png',
                          width: 100,
                          height: 100,
                        )
                      : Image.asset(
                          'assets/icon/live_event/work_event_icon.png',
                          width: 100,
                          height: 100,
                        ),
                ],
              ),
              postModel.share_post_id!.event_type == 'education'
                  ? Text(
                      postModel.share_post_id!.event_sub_type!
                              .contains('New School')
                          ? 'Started School at ${postModel.share_post_id!.institute_id!.instituteName}'
                          : postModel.event_sub_type!.contains('Graduate')
                              ? 'Graduated from ${postModel.share_post_id!.institute_id!.instituteName}'
                              : postModel.event_sub_type!
                                      .contains('Post Graduated')
                                  ? 'Graduated from ${postModel.share_post_id!.institute_id!.instituteName}'
                                  : 'Left School from ${postModel.share_post_id!.institute_id!.instituteName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      postModel.share_post_id!.event_sub_type!
                              .contains('New Job')
                          ? 'Started New Job at ${postModel.share_post_id!.workplace_id!.orgName}'
                          : postModel.share_post_id!.event_sub_type!
                                  .contains('Promotion')
                              ? 'Promoted at Job ${postModel.share_post_id!.workplace_id!.orgName}'
                              : postModel.share_post_id!.event_sub_type!
                                      .contains('Left Job')
                                  ? 'Left Job from ${postModel.share_post_id!.workplace_id!.orgName}'
                                  : 'Retirement from ${postModel.share_post_id!.workplace_id!.orgName}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
              postModel.share_post_id!.event_type == 'education'
                  ? Text(
                      postModel.event_sub_type!.contains('New School')
                          ? getDynamicFormatedTime(postModel
                              .share_post_id!.institute_id!.startDate
                              .toString())
                          : postModel.share_post_id!.event_sub_type!
                                  .contains('Graduate')
                              ? getDynamicFormatedTime(postModel
                                  .share_post_id!.institute_id!.endDate
                                  .toString())
                              : getDynamicFormatedTime(postModel
                                  .share_post_id!.institute_id!.endDate
                                  .toString()),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      ),
                    )
                  : Text(
                      postModel.share_post_id!.event_sub_type!
                              .contains('New Job')
                          ? getDynamicFormatedTime(postModel
                              .share_post_id!.workplace_id!.fromDate
                              .toString())
                          : postModel.share_post_id!.event_sub_type!
                                  .contains('Promotion')
                              ? getDynamicFormatedTime(postModel
                                  .share_post_id!.workplace_id!.fromDate
                                  .toString())
                              : postModel.event_sub_type!.contains('Left Job')
                                  ? getDynamicFormatedTime(postModel
                                      .share_post_id!.workplace_id!.toDate
                                      .toString())
                                  : getDynamicFormatedTime(postModel
                                      .share_post_id!.workplace_id!.toDate
                                      .toString()),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      )),
            ],
          )
        : postModel.share_post_id!.link_image == null ||
                postModel.share_post_id!.link_image == ''
            ? ((postModel.shareMedia?.length ?? 0) > 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(postModel.share_post_id!.description ?? ''),
                      ),
                      ((postModel.shareMedia?.length ?? 0) > 1)
                          ? SizedBox(
                              height: 500,
                              child: MediaGridView(
                                  mediaUrls: imageUrls,
                                  onTapViewMoreMedia: onTapViewMoreMedia),
                            )
                          : PrimaryNetworkImage(imageUrl: imageUrls[0]),
                    ],
                  )
                : ((postModel.shareMedia?.length ?? 0) == 0)
                    ? Container(
                        // =================================================== No Meida Post ===================================================
                        height: (postModel
                                        .share_post_id!.post_background_color !=
                                    null &&
                                postModel.share_post_id!.post_background_color!
                                    .isNotEmpty &&
                                postModel.share_post_id!
                                        .post_background_color! !=
                                    '')
                            ? 256
                            : null, // not having background color will make height dynamic
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: (postModel.share_post_id!
                                            .post_background_color !=
                                        null &&
                                    postModel.share_post_id!
                                        .post_background_color!.isNotEmpty)
                                ? Color(int.parse(
                                    '0xff${postModel.share_post_id!.post_background_color}'))
                                : null),
                        padding: const EdgeInsets.all(10),
                        child:
                            (postModel.share_post_id!.post_background_color !=
                                        null &&
                                    postModel.share_post_id!
                                            .post_background_color !=
                                        '')
                                ? Center(
                                    child: Text(
                                      '${postModel.share_post_id!.description}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                : ExpandableText(
                                    '${postModel.share_post_id!.description}',
                                    expandText: 'See more',
                                    maxLines: 5,
                                    collapseText: 'see less',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                      )
                    : Column(
                        // Link post design
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: RichText(
                                text: TextSpan(
                                    children: getTextWithLink(
                                        postModel.share_post_id!.description ??
                                            ''))),
                          ),
                          GestureDetector(
                              onTap: () async {
                                String url =
                                    postModel.share_post_id!.link.toString();
                                await launchUrl(Uri.parse(url));
                              },
                              child: PrimaryNetworkImage(
                                  imageUrl:
                                      postModel.share_post_id!.link_image!)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  postModel.share_post_id!.link_title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    postModel.share_post_id!.link_description ??
                                        ''),
                              ],
                            ),
                          )
                        ],
                      )
            : Column(
                // Link post design
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                        text: TextSpan(
                            children: getTextWithLink(
                                postModel.share_post_id!.description ?? ''))),
                  ),
                  GestureDetector(
                      onTap: () async {
                        String url = postModel.share_post_id!.link.toString();
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      },
                      child: PrimaryNetworkImage(
                          imageUrl: postModel.share_post_id!.link_image!)),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          postModel.share_post_id!.link_title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(postModel.share_post_id!.link_description ?? ''),
                      ],
                    ),
                  )
                ],
              );
  }
}

//=============================================================== Event Post

class EventPost extends StatelessWidget {
  const EventPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//=============================================================== Shared Reels Post

class SharedReelsPost extends StatelessWidget {
  const SharedReelsPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//=============================================================== Birthday Post

class BirthdayPost extends StatelessWidget {
  const BirthdayPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//=============================================================== Campain Post

class CampainPost extends StatelessWidget {
  const CampainPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        postModel.campaign_id?.campaign_cover_pic!.length == 1
            ? PrimaryNetworkImage(
                imageUrl: getFormatedPostUrl(
                    '${postModel.campaign_id?.campaign_cover_pic?[0]}'),
              )
            : CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 6 / 3,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  scrollPhysics: const BouncingScrollPhysics(),
                ),
                items: postModel.campaign_id?.campaign_cover_pic!
                    .map(
                      (item) => Container(
                          height: 256,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                          ),
                          child: Image(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(getFormatedPostUrl(item)))),
                    )
                    .toList(),
              ),
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade400),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${postModel.campaign_id?.website_url}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${postModel.campaign_id?.headline}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              PrimaryOutlinedButton(
                color: Colors.black,
                verticalPadding: 10,
                horizontalPadding: 20,
                onPressed: () {},
                text: '${postModel.campaign_id?.call_to_action}',
              )
            ],
          ),
        )
      ],
    );
  }
}

String getDynamicFormatedTime(String time) {
  // print("time of date ........."+time);

  DateTime postDateTime;
  if (time.toString() == 'null' || time.isEmpty || time.toString() == '') {
    postDateTime = DateTime.now().toLocal();
  } else {
    postDateTime = DateTime.parse(time).toLocal();
  }
  return productDateTimeFormate.format(postDateTime);
}
