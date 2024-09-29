import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/image.dart';
import 'image.dart';

class AddStoryWidget extends StatelessWidget {
  const AddStoryWidget({
    super.key,
    required this.userModel,
    required this.onTapCreateStory,
  });
  final VoidCallback onTapCreateStory;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCreateStory,
      child: Stack(
        children: [
          RoundCornerNetworkImage(
              height: 116.48,
              width: 80.64,
              imageUrl: getFormatedProfileUrl(userModel.profile_pic ?? '')),
          Positioned(
              top: 105,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.add_box,
                  color: Colors.blue,
                ),
              )),
          const Positioned(
            top: 130,
            left: 10,
            child: Text(''),
          )
        ],
      ),
    );
  }
}
