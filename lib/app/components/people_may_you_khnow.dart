import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/NAVIGATION_MENUS/friend/model/people_may_you_khnow.dart';
import '../routes/app_pages.dart';
import '../utils/color.dart';
import '../utils/image.dart';

class PeopleMayYouKnowCard extends StatelessWidget {
  const PeopleMayYouKnowCard({
    super.key,
    required this.peopleMayYouKnowModel,
    required this.onPressedAddFriend,
    required this.onPressedRemove,
  });
  final PeopleMayYouKnowModel peopleMayYouKnowModel;
  final VoidCallback onPressedAddFriend;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: Get.width * 0.30,
        width: Get.width * 0.16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                getFormatedProfileUrl(peopleMayYouKnowModel.profile_pic ?? '')),
          ),
        ),
      ),
      title: InkWell(
        onTap: (){

          Get.toNamed(Routes.OTHERS_PROFILE, arguments: peopleMayYouKnowModel.username);


        },
        child: Text(
          '${peopleMayYouKnowModel.first_name ?? ''} ${peopleMayYouKnowModel.last_name ?? ''}',
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
                  onPressed: onPressedAddFriend,
                  child: const Text(
                    'Add Friend',
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
                  onPressed: onPressedRemove,
                  child: const Text(
                    'Remove',
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
