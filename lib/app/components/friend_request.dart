// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_possibilities_flutter/app/models/firend_request.dart';
import 'package:quantum_possibilities_flutter/app/models/user_id.dart';
import 'package:quantum_possibilities_flutter/app/utils/image.dart';

import '../routes/app_pages.dart';
import '../utils/color.dart';

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard({
    super.key,
    required this.friendRequestModel,
    required this.onPressedAccept,
    required this.onPressedReject,
  });
  final FriendRequestModel friendRequestModel;
  final VoidCallback onPressedAccept;
  final VoidCallback onPressedReject;

  @override
  Widget build(BuildContext context) {
    UserIdModel userIdModel = friendRequestModel.user_id!;
    return ListTile(
      leading: Container(
        height: Get.width * 0.30,
        width: Get.width * 0.16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                getFormatedProfileUrl(userIdModel.profile_pic ?? '')),
          ),
        ),
      ),
      title: InkWell(
        onTap: (){

          Get.toNamed(Routes.OTHERS_PROFILE, arguments: friendRequestModel.user_id?.username);



        },
        child: Text(
          '${userIdModel.first_name ?? ''} ${userIdModel.last_name ?? ''}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1 mutual friend',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade700),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 35,
                width: Get.width * 0.24,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: onPressedAccept,
                  child: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 35,
                width: Get.width * 0.24,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: onPressedReject,
                  child: const Text(
                    'Decline',
                    style: TextStyle(color: PRIMARY_COLOR),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
