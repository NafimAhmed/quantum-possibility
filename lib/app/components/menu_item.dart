import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  final Widget image;
  final String tileName;
  final VoidCallback onTap;
  const MenuItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.tileName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        width: Get.width,
        child: Row(
          children: [
            image,
            Text(
              tileName,
              //'Group',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
