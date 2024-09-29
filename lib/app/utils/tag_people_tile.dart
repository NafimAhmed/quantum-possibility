




import 'package:flutter/material.dart';

import '../components/image.dart';
import 'image.dart';

class TagPeopleTile extends StatelessWidget{

  final String text;
  final String imageURL;

   TagPeopleTile({super.key, required this.text, required this.imageURL});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 10.0),
          child: NetworkCircleAvatar(
            imageUrl: getFormatedProfileUrl(
                imageURL
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(text,overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }

}