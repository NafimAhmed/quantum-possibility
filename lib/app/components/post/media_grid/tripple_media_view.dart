part of 'media_grid.dart';

class TrippleMediaView extends StatelessWidget {
  const TrippleMediaView({
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
            child: ContentView(
              url: mediaUrls[0],
              imageHeight: 500,
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
                  child: ContentView(
                    url: mediaUrls[2],
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
