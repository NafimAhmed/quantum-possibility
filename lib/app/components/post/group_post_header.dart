import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/login_creadential.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../models/user_id.dart';
import '../../routes/app_pages.dart';
import '../../utils/image.dart';
import '../../utils/post_utlis.dart';
import '../image.dart';

class GroupPostHeader extends StatelessWidget {
  final PostModel model;

  const GroupPostHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    UserIdModel userModel = model.user_id!;
    UserModel currentUserModel = LoginCredential().getUserData();
    return

      Container(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.OTHERS_PROFILE, arguments: userModel);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Stack(
                children: [
                  RoundCornerNetworkImage(
                    imageUrl: getFormatedGroupProfileUrl(
                      model.groupId!.groupCoverPic ?? '',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -5,
                    child: NetworkCircleAvatar(imageUrl: getFormatedProfileUrl(
                      model.user_id!.profile_pic ?? '',
                    ),
                      radius: 14,

                    ),
                  )
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: '${model.groupId!.groupName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: ' ${getHeaderTextAsPostType(model)}',
                              style: TextStyle(
                                  color: Colors.grey.shade700, fontSize: 16))
                        ])),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '${userModel!.first_name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                  text: ' ${getHeaderTextAsPostType(model)}',
                                  style: TextStyle(
                                      color: Colors.grey.shade700, fontSize: 16))
                            ])),
                        Text('${getDynamicFormatedTime(model.createdAt ?? '')}',overflow: TextOverflow.ellipsis,),
                        Text(
                          getTextAsPostType(model.post_type ?? ''),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          getIconAsPrivacy(model.post_privacy ?? ''),
                          size: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // =========================================================== Three Dot Icon ===========================================================

            ],
          ),
        ),
      )

    ;
  }

  getIconAsPrivacy(String postPrivacy) {
    switch (postPrivacy) {
      case 'public':
        return Icons.public;
      case 'private':
        return Icons.lock;
      case 'friends':
        return Icons.group;
      default:
        return Icons.public;
    }
  }

  String getTextAsPostType(String postType) {
    switch (postType) {
      case 'campaign':
        return 'Sponsored ';
      default:
        return '';
    }
  }

  String getHeaderTextAsPostType(PostModel postModel) {
    switch (model.post_type) {
      case 'timeline_post':
        return '';
      case 'page_post':
        return '';
      case 'profile_picture':
        return 'updated his profile picture';
      case 'cover_picture':
        return 'updated his cover photo';
      case 'event':
        return '';
      case 'shared_reels':
        return '';
      case 'birthday':
        return '';
      case 'campaign':
        return '';
      default:
        return '';
    }
  }

  String getSharedHeaderTextAsPostType(PostModel postModel) {
    switch (model.share_post_id!.post_type) {
      case 'timeline_post':
        return '';
      case 'page_post':
        return '';
      case 'profile_picture':
        return 'updated his profile picture';
      case 'cover_picture':
        return 'updated his cover photo';
      case 'event':
        return '';
      case 'shared_reels':
        return '';
      case 'birthday':
        return '';
      case 'campaign':
        return '';
      default:
        return '';
    }
  }
}
