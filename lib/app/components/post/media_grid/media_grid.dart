import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/image.dart';
import '../../image.dart';
import '../../single_image.dart';
import '../../video_player.dart';

part 'double_media_view.dart';
part 'fourple_media_view.dart';
part 'more_media_view.dart';
part 'single_media_view.dart';
part 'tripple_media_view.dart';

class MediaGridView extends StatelessWidget {
  const MediaGridView({
    super.key,
    required this.mediaUrls,
    required this.onTapViewMoreMedia,
  });
  final VoidCallback onTapViewMoreMedia;
  final List<String> mediaUrls;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapViewMoreMedia,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: getViewAsMedia(mediaUrls),
      ),
    );
  }
}

Widget getViewAsMedia(List<String> mediaUrls) {
  switch (mediaUrls.length) {
    case 1:
      return SingleMediaView(mediaUrls: mediaUrls);
    case 2:
      return DoubleMediaView(mediaUrls: mediaUrls);
    case 3:
      return TrippleMediaView(mediaUrls: mediaUrls);
    case 4:
      return FourpleMediaView(mediaUrls: mediaUrls);
    default:
      return MoreMediaView(mediaUrls: mediaUrls);
  }
}

class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.url,
    this.imageHeight = 250,
  });
  final String url;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {


    return isImageUrl(url)
        ?
              GestureDetector(
                  onTap: (){
                    Get.to(
                            () => SingleImage(imgURL: url)

                    );
                  },

                  child: PrimaryNetworkImage(imageUrl: url))
        : SizedBox(
            height: 250,
            child: VideoPlay(videoLink: url),
          );
  }
}
