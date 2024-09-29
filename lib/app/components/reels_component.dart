import 'package:carousel_slider/carousel_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../data/login_creadential.dart';
import '../modules/NAVIGATION_MENUS/video/controllers/video_controller.dart';

import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../config/api_constant.dart';
import '../modules/NAVIGATION_MENUS/video/model/reels_model.dart';
import '../utils/color.dart';

import '../utils/date_time.dart';
import '../utils/image.dart';
import 'image.dart';

class ReelsComponent extends StatefulWidget {
  final bool isLiked;

  final CarouselController carouselController;
  final ReelsModel reelsModel;
  final VoidCallback onPressedLike;
  final Function(String value) onPressedComment;
  const ReelsComponent({
    super.key,
    required this.carouselController,
    required this.isLiked,
    required this.reelsModel,
    required this.onPressedLike,
    required this.onPressedComment,
  });

  @override
  State<ReelsComponent> createState() => _ReelsComponentState();
}

class _ReelsComponentState extends State<ReelsComponent> {
  VideoController videoController = Get.find();
  late VideoPlayerController _controller;

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        '${ApiConstant.SERVER_IP_PORT}/uploads/reels/${widget.reelsModel.video}'))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Rx<bool> isPlaying = true.obs;

    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: Get.height - 130,
          width: Get.width,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Center(
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller)),
              ),
              Center(
                child: IconButton(
                  onPressed: () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    isPlaying.value = !isPlaying.value;
                  },
                  icon: Obx(
                    () => isPlaying.value
                        ? const Icon(
                            Icons.pause,
                            size: 40,
                            color: Colors.transparent,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
        ),
        Positioned(
          top: 30,
          left: Get.width - 110,
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(10)),
            child: const Text(
              'Create Reels',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NetworkCircleAvatar(
                        imageUrl: getFormatedProfileUrl(
                            widget.reelsModel.reel_user?.profile_pic ?? '')),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.reelsModel.reel_user?.first_name ?? ''} ${widget.reelsModel.reel_user?.last_name ?? ''}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              '${postDateTimeFormate.format(DateTime.parse(widget.reelsModel.createdAt ?? '').toLocal())} . ',
                              // reelsModel.createdAt ?? '',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              widget.reelsModel.reels_privacy == '' ||
                                      widget.reelsModel.reels_privacy == null ||
                                      widget.reelsModel.reels_privacy == 'null'
                                  ? 'Public'
                                  : '${widget.reelsModel.reels_privacy}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width - 20,
                  child: ReadMoreText(
                    '${widget.reelsModel.description}',
                    //maxLines: 2,
                    trimCollapsedText: 'more',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                IconButton(
                  onPressed: widget.onPressedLike,
                  icon: Icon(
                    Icons.thumb_up,
                    size: 30,
                    color: widget.isLiked == true ? Colors.blue : Colors.white,
                  ),
                ),
                Text(
                  '${widget.reelsModel.reaction_count}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () async {
                    await videoController
                        .getReelCommentList(widget.reelsModel.id ?? '');

                    Get.bottomSheet(
                      Container(
                          height: Get.height - 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0)),
                            child: SizedBox(
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: Get.width,
                                      color: Colors.white,
                                      child: Obx(
                                        () => videoController
                                                    .isCommentLoading.value ==
                                                true
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: videoController
                                                    .reelsCommentModl
                                                    .value
                                                    .comments
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        RoundCornerNetworkImage(
                                                          imageUrl: getFormatedProfileUrl(
                                                              videoController
                                                                      .reelsCommentModl
                                                                      .value
                                                                      .comments?[
                                                                          index]
                                                                      .userId
                                                                      .profilePic ??
                                                                  ''),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          05),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${videoController.reelsCommentModl.value.comments?[index].userId.firstName} ${videoController.reelsCommentModl.value.comments?[index].userId.lastName}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width -
                                                                            200,
                                                                    child: Text(
                                                                        '${videoController.reelsCommentModl.value.comments?[index].commentName}'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    '1 h'),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                const Text(
                                                                    'Like'),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      TextEditingController
                                                                          commentReplyController =
                                                                          TextEditingController();
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (ctx) =>
                                                                                AlertDialog(
                                                                          title:
                                                                              const Text('Reply'),
                                                                          content:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(width: 1, color: Colors.grey),
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                TextField(
                                                                              maxLines: 3,
                                                                              controller: commentReplyController,
                                                                              decoration: const InputDecoration(
                                                                                border: InputBorder.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                videoController.reelsCommentsReply(videoController.reelsCommentModl.value.comments![index].id, '${LoginCredential().getUserData().id}', commentReplyController.text, widget.reelsModel.id ?? '');
                                                                                //Navigator.of(ctx).pop();
                                                                              },
                                                                              child: Container(
                                                                                color: Colors.transparent,
                                                                                padding: const EdgeInsets.all(14),
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Icon(Icons.send),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Text('Reply'),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                        'Reply')),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                for (int j = 0;
                                                                    j <
                                                                        videoController
                                                                            .reelsCommentModl
                                                                            .value
                                                                            .comments![index]
                                                                            .replies
                                                                            .length;
                                                                    j++)
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      NetworkCircleAvatar(
                                                                        imageUrl: getFormatedProfileUrl(videoController
                                                                            .reelsCommentModl
                                                                            .value
                                                                            .comments![index]
                                                                            .replies[j]
                                                                            .repliesUserId
                                                                            .profilePic),
                                                                        radius:
                                                                            15,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              05),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colors.grey.shade300),
                                                                          child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                '${videoController.reelsCommentModl.value.comments![index].replies[j].repliesUserId.firstName} ${videoController.reelsCommentModl.value.comments![index].replies[j].repliesUserId.lastName}',
                                                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Text(videoController.reelsCommentModl.value.comments![index].replies[j].repliesCommentName),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RoundCornerNetworkImage(
                                        imageUrl: getFormatedProfileUrl(
                                            LoginCredential()
                                                    .getUserData()
                                                    .profile_pic ??
                                                ''),
                                      ),
                                      InkWell(
                                        child: Container(
                                          height: 40,
                                          width: Get.width - 140,
                                          padding: const EdgeInsets.all(5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: TextField(
                                            controller: commentController,
                                            decoration: const InputDecoration(
                                              hintText: 'Write a comment',
                                              border: InputBorder.none,
                                              isCollapsed: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.1),
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              widget.onPressedComment(
                                                  commentController.text);
                                            },
                                            icon: const Icon(Icons.send)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                  icon: const Icon(
                    Icons.mode_comment,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  '${widget.reelsModel.comment_count}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                const SizedBox(height: 20),
                PopupMenuButton(
                    color: Colors.transparent,
                    offset: const Offset(-50, -170),
                    iconColor: Colors.white,
                    icon: Image.asset(
                      'assets/other/reelshare.png',
                      height: 30,
                      width: 30,
                    ),
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            // row has two child icon and text.
                            child: Text(
                              'News Feed',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Share.share(
                                  'Reels: https://quantumpossibilities.eu/reels/${widget.reelsModel.id ?? ''}    ',
                                  subject: 'Look at this');
                            },
                            value: 1,
                            // row has two child icon and text.
                            child: const Text(
                              'Facebook',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Share.share(
                                  'Reels: https://quantumpossibilities.eu/reels/${widget.reelsModel.id ?? ''}    ',
                                  subject: 'Look at this');
                            },
                            value: 1,
                            // row has two child icon and text.
                            child: const Text(
                              'Twitter',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Share.share(
                                  'Reels: https://quantumpossibilities.eu/reels/${widget.reelsModel.id ?? ''}    ',
                                  subject: 'Look at this');
                            },
                            value: 1,
                            // row has two child icon and text.
                            child: const Text(
                              'Whatsapp',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                PopupMenuButton(
                    color: Colors.transparent,
                    offset: const Offset(-50, -100),
                    iconColor: Colors.white,
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            // row has two child icon and text.
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 1,
                            // row has two child icon and text.
                            child: Text(
                              'Report',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                const Text(
                  '',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ))
      ],
    );
  }
}
