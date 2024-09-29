import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color.dart';

class WorkTile extends StatelessWidget {
  final String companyName;
  final Widget tileIcon;
  final String timeDuration;
  final String privacy;

  const WorkTile(
      {super.key,
      required this.companyName,
      required this.timeDuration,
      required this.privacy,
      required this.tileIcon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child:
                    tileIcon, //Icon(Icons.business_center,size: 40,color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 1.7,
                    child: Text(
                      companyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Text(
                        timeDuration), //timeDuration!=null||timeDuration!="null"?true:false,
                  ),
                  Text(privacy),
                ],
              ),
            ],
          ),
          IconButton(
              splashColor: Colors.grey,
              onPressed: () {},
              icon: const Icon(
                Icons.edit_outlined,
                size: 25,
                color: PRIMARY_COLOR,
              ))
        ],
      ),
    );
  }
}
