import 'package:flutter/material.dart';

import '../utils/reaction_stack.dart';

class ReactionListTile extends StatelessWidget {
  final String name;
  final String profilePicUrl;
  final String reaction;

  const ReactionListTile(
      {super.key,
      required this.name,
      required this.profilePicUrl,
      required this.reaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ReactionStack(
        profileImageLink: profilePicUrl,
        reactionImageLink: reaction,
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
