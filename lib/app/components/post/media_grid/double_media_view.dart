part of 'media_grid.dart';

class DoubleMediaView extends StatelessWidget {
  const DoubleMediaView({
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
                url: mediaUrls.first,
                imageHeight: 500,
              )),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
              height: 500,
              child: ContentView(
                url: mediaUrls.last,
                imageHeight: 500,
              )),
        ),
      ],
    );
  }
}
