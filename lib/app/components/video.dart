import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PrimaryVideoPlayer extends StatelessWidget {
  const PrimaryVideoPlayer({
    super.key,
    required this.mediaUrl,
  });
  final String mediaUrl;

  @override
  Widget build(BuildContext context) {


    Rx<bool> isPlaying = false.obs;
    final VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(mediaUrl));
    controller.addListener(() {
      if (controller.value.position == controller.value.duration) {
        isPlaying.value = false;
      }
    });
    controller.initialize();
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        VideoPlayer(controller),
        IconButton(
          onPressed: () {
            if (isPlaying.value) {
              controller.pause();
            } else {
              controller.play();
            }
            isPlaying.value = !isPlaying.value;
          },
          icon:
              Obx(() => Icon(isPlaying.value ? Icons.pause : Icons.play_arrow)),
        ),
        VideoProgressIndicator(
          controller,
          allowScrubbing: true,
          colors: const VideoProgressColors(
            playedColor: Colors.red,
            bufferedColor: Colors.grey,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
