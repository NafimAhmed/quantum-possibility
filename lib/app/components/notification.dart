// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quantum_possibilities_flutter/app/components/image.dart';
import 'package:quantum_possibilities_flutter/app/models/notification.dart';
import 'package:quantum_possibilities_flutter/app/utils/image.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.model,
  });
  final NotificationModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (model.notification_seen ?? false)
              ? Colors.white
              : Colors.blue.shade50),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundCornerNetworkImage(
            imageUrl: getFormatedProfileUrl(
                model.notification_sender_id?.profile_pic ?? ''),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text:
                    '${model.notification_sender_id?.first_name} ${model.notification_sender_id?.last_name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                  text: ' ${getTextAsNotificationType(model)}',
                  style: const TextStyle(color: Colors.black, fontSize: 16))
            ])),
          ),
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.more_horiz))
        ],
      ),
    );
  }

  String getTextAsNotificationType(NotificationModel model) {
    switch (model.notification_type) {
      case 'post_reaction':
        return 'has reacted on your post';
      case 'post_commented':
        return 'has commented on your post';
      case 'reel_post_reaction':
        return 'has reacted on your reel';
      case 'comment_reaction':
        return 'has reacted on your comment';
      case 'follow_request':
        return 'is following you';
      default:
        return 'Notification type not found';
    }
  }
}
