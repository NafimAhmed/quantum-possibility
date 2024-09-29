import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../config/app_assets.dart';

class PrifileViewBannerImage extends StatelessWidget {
  final String banner;
  final String profilePic;

  final bool enableImageUpload;
  final Callback? profileImageUpload;
  final Callback? coverImageUpload;

  const PrifileViewBannerImage(
      {super.key,
      required this.banner,
      required this.profilePic,
      required this.enableImageUpload,
      this.profileImageUpload,
      this.coverImageUpload});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 305,
      child: Stack(
        children: [
          Positioned(
            child: Image.network(
              banner,
              width: Get.width,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppAssets.DEFAULT_IMAGE,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 30,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: 30,
            child: Visibility(
              visible: enableImageUpload,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: () {
                    coverImageUpload!();
                    //Get.back();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: Get.width / 3.6,
            bottom: 5,
            child: Stack(
              children: [
                Container(
                    height: 156,
                    width: 156,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              profilePic,
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 4,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        width: double.maxFinite,
                        height: 256,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          profilePic,
                        ),
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage(AppAssets.DEFAULT_PROFILE_IMAGE),
                          );
                        },
                      ),
                    )),
                Visibility(
                  visible: enableImageUpload,
                  child: Positioned(
                      right: 15,
                      bottom: 15,
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          onPressed: () {
                            profileImageUpload!();
                            //Get.back();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
