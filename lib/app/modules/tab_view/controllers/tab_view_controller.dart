import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/login_creadential.dart';
import '../../../utils/color.dart';
import '../../NAVIGATION_MENUS/cart/controllers/cart_controller.dart';
import '../../NAVIGATION_MENUS/friend/controllers/friend_controller.dart';
import '../../NAVIGATION_MENUS/home/controllers/home_controller.dart';
import '../../NAVIGATION_MENUS/marketplace/controllers/marketplace_controller.dart';
import '../../NAVIGATION_MENUS/notification/controllers/notification_controller.dart';
import '../../NAVIGATION_MENUS/user_menu/controllers/user_menu_controller.dart';
import '../../NAVIGATION_MENUS/video/controllers/video_controller.dart';

class TabViewController extends GetxController {
  final int tabLength = 7;
  late LoginCredential loginCredential;
  RxInt tabIndex = 0.obs;

  void initializeAllRequiredController() {
    Get.put(HomeController());
    Get.put(VideoController());
    Get.put(FriendController());
    Get.put(NotificationController());
    Get.put(CartController());
    Get.put(MarketplaceController());
    Get.put(UserMenuController());
    // Get.put(NotificationPostController());
    // Get.put(ProfileController());
    // Get.put(SharePostController());
    // Get.put(EditPostController());
  }

  showExitDialog(BuildContext context) async {
    if (DefaultTabController.of(context).index == 0) {
      // On Home tab
      Get.dialog(AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Exit QP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      const Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Are you sure, you want to exit?',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: PRIMARY_COLOR,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'No',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    } else {
      // Other tab
      tabIndex.value = 0;
      DefaultTabController.of(context).animateTo(0);
    }
  }

  @override
  void onInit() {
    loginCredential = LoginCredential();
    initializeAllRequiredController();
    super.onInit();
  }
}
