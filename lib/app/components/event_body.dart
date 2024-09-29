import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/shared/create_post/view/education_sub_type_view.dart';
import '../modules/shared/create_post/view/event_sub_type_view.dart';

class EventBody extends StatelessWidget {
  const EventBody(
      {super.key,
      required this.item,
      required this.imageLink,
      required this.title});
  final List<String> item;
  final String imageLink;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageLink,
              width: 100,
              height: 100,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            item.length,
            (index) => GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (title.contains('Work')) {
                          Get.to(() => EventSubTypeView(),
                              arguments: item[index]);
                        } else {
                          Get.to(() => EducationSubTypeView(),
                              arguments: item[index]);
                        }
                      },
                      child: Text(
                        item[index].toUpperCase(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 12.0),
                    child: Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
