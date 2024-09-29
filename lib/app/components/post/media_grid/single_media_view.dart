part of 'media_grid.dart';


class SingleMediaView extends StatelessWidget {
  const SingleMediaView({
    super.key,
    required this.mediaUrls,
  });
  final List<String> mediaUrls;

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          height: 250,
          child: ContentView(
            url: mediaUrls.first,
            imageHeight: 250,
          ));
  }
}
