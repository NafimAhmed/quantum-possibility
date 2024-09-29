import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_assets.dart';
import '../utils/color.dart';

class AppbarImageIcon extends StatelessWidget {
  const AppbarImageIcon({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: PRIMARY_LIGHT_COLOR,
      ),
      child: Image(
        height: 20,
        image: AssetImage(imagePath),
      ),
    );
  }
}

class NavigationbarImage extends StatelessWidget {
  const NavigationbarImage({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.green.shade100,
      ),
      child: Image(
        height: 20,
        image: AssetImage(imagePath),
      ),
    );
  }
}

class NetworkCircleAvatar extends StatelessWidget {
  const NetworkCircleAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 24,
  });

  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}

class PrimaryNetworkImage extends StatelessWidget {
  const PrimaryNetworkImage({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return imageUrl.contains('.svg')
        ? SvgPicture.network(
            imageUrl,
            height: 256,
            fit: BoxFit.fitWidth,
          )
        : Image(
            height: 256,
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl,
            ),
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                image: AssetImage(AppAssets.DEFAULT_IMAGE),
              );
            },
          );
  }
}

class RoundCornerNetworkImage extends StatelessWidget {
  const RoundCornerNetworkImage({
    super.key,
    required this.imageUrl,
    this.height = 50,
    this.width = 50,
  });
  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image(
        height: height,
        width: width,
        fit: BoxFit.cover,
        image: NetworkImage(
          imageUrl,
        ),
        errorBuilder: (context, error, stackTrace) {
          return Image(
            height: height,
            width: width,
            fit: BoxFit.cover,
            image: const AssetImage(AppAssets.DEFAULT_PROFILE_IMAGE),
          );
        },
      ),
    );
  }
}
