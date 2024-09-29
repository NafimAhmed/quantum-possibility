import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/image.dart';
import '../../../config/app_assets.dart';
import '../../../utils/color.dart';
import '../../NAVIGATION_MENUS/cart/views/cart_view.dart';
import '../../NAVIGATION_MENUS/friend/views/friend_view.dart';
import '../../NAVIGATION_MENUS/home/views/home_view.dart';
import '../../NAVIGATION_MENUS/marketplace/views/marketplace_view.dart';
import '../../NAVIGATION_MENUS/notification/views/notification_view.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/views/profile_view.dart';
import '../../NAVIGATION_MENUS/video/views/video_view.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              height: 32,
              width: 32,
              image: AssetImage(AppAssets.APP_LOGO),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppbarImageIcon(
                    imagePath: AppAssets.UPLOAD_TYPE_APPBAR_ICON,
                  ),
                  SizedBox(width: 10),
                  AppbarImageIcon(
                    imagePath: AppAssets.SEARCH_APPBAR_ICON,
                  ),
                  SizedBox(width: 10),
                  AppbarImageIcon(
                    imagePath: AppAssets.MESSAGE_APPBAR_ICON,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Obx(() => SafeArea(
            child: Column(
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedFontSize: 0,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  currentIndex: controller.currentIndex,
                  onTap: controller.changeIndex,
                  items: [
                    NavBarItem(
                      label: 'Home',
                      iconPath: AppAssets.HOME_NAVBAR_ICON,
                      index: 0,
                    ),
                    NavBarItem(
                      label: 'Video',
                      iconPath: AppAssets.VIDEO_NAVBAR_ICON,
                      index: 1,
                    ),
                    NavBarItem(
                      label: 'Friend',
                      iconPath: AppAssets.FRIEND_NAVBAR_ICON,
                      index: 2,
                    ),
                    NavBarItem(
                      label: 'Notification',
                      iconPath: AppAssets.NOTIFICATION_NAVBAR_ICON,
                      index: 3,
                    ),
                    NavBarItem(
                      label: 'Cart',
                      iconPath: AppAssets.CART_NAVBAR_ICON,
                      index: 4,
                    ),
                    NavBarItem(
                      label: 'MarketPlace',
                      iconPath: AppAssets.MARKET_PLACE_NAVBAR_ICON,
                      index: 5,
                    ),
                    NavBarItem(
                      label: 'Profile',
                      iconPath: AppAssets.UPLOAD_TYPE_APPBAR_ICON,
                      index: 6,
                    ),
                  ],
                ),
                Obx(() => Expanded(
                      child: IndexedStack(
                        index: controller.currentIndex,
                        children: const [
                          HomeView(),
                          VideoView(),
                          FriendView(),
                          NotificationView(),
                          CartView(),
                          MarketplaceView(),
                          ProfileView(),
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  BottomNavigationBarItem NavBarItem({
    String? label,
    required String iconPath,
    required int index,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Container(
        margin: EdgeInsets.zero,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: controller.currentIndex == index
              ? PRIMARY_LIGHT_COLOR
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Image(
          image: AssetImage(iconPath),
        ),
      ),
    );
  }
}
