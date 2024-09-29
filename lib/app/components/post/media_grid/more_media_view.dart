part of 'media_grid.dart';

class MoreMediaView extends StatelessWidget {
  const MoreMediaView({
    super.key,
    required this.mediaUrls,
  });
  final List<String> mediaUrls;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                Expanded(
                  child: ContentView(
                    url: mediaUrls[0],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ContentView(
                    url: mediaUrls[2],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            height: 500,
            child: Column(
              children: [
                Expanded(
                  child: ContentView(
                    url: mediaUrls[1],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: ContentView(
                          url: mediaUrls[3],
                        ),
                      ),
                      Container(
                        height: 250,
                        width: Get.width / 2,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                        child: Center(
                          child: Text(
                            '${(mediaUrls.length - 4)}+',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
