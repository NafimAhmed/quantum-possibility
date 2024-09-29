import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';
import '../../../data/login_creadential.dart';
import '../../../utils/image.dart';
import '../../NAVIGATION_MENUS/cart/views/cart_view.dart';
import '../../NAVIGATION_MENUS/friend/views/friend_view.dart';
import '../../NAVIGATION_MENUS/home/views/home_view.dart';
import '../../NAVIGATION_MENUS/marketplace/views/marketplace_view.dart';
import '../../NAVIGATION_MENUS/notification/views/notification_view.dart';
import '../../NAVIGATION_MENUS/user_menu/views/user_menu_view.dart';
import '../../NAVIGATION_MENUS/video/views/video_view.dart';
import '../controllers/tab_view_controller.dart';

class TabView extends GetView<TabViewController> {
  const TabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: 25,
                  height: 25,
                ),
                const Text('uantum',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.transparent,
                    )),
                const Text(
                  ' Possibilities',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.transparent),
                ),
              ],
            ),
            const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 223, 252, 252),
                  radius: 15,
                  child: Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 223, 252, 252),
                  radius: 15,
                  child: Icon(
                    Icons.search_rounded,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 223, 252, 252),
                  radius: 15,
                  child: Icon(
                    Icons.forum_outlined,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: bodyData(),
    );
  }

  Widget bodyData() {
    return DefaultTabController(
      initialIndex: 0, //intitIndex.value,
      length: controller.tabLength, // Tab length
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: false,
            onPopInvoked: (boolValue) {
              controller.showExitDialog(context);
            },
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: Get.width,
                          decoration: const BoxDecoration(
                              // color: Color(0xffE5E5E5),
                              ),
                          child: TabBar(
                            onTap: (index) {
                              controller.tabIndex.value = index;
                            },
                            dividerHeight: 2,
                            indicatorWeight: 0,
                            physics: const NeverScrollableScrollPhysics(),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                              insets: EdgeInsets.symmetric(horizontal: 0),
                            ),
                            isScrollable: false,
                            dividerColor: Colors.grey.shade300,
                            tabs: [
                              Image.asset(
                                AppAssets.HOME_NAVBAR_ICON,
                                height: 16,
                                width: 16,
                              ),
                              Image.asset(
                                AppAssets.VIDEO_NAVBAR_ICON,
                                height: 16,
                                width: 16,
                              ),
                              Image.asset(
                                AppAssets.FRIEND_NAVBAR_ICON,
                                height: 16,
                                width: 17,
                              ),
                              Image.asset(
                                AppAssets.NOTIFICATION_NAVBAR_ICON,
                                height: 21,
                                width: 21,
                              ),
                              Image.asset(
                                AppAssets.CART_NAVBAR_ICON,
                                height: 18,
                                width: 18,
                              ),
                              Image.asset(
                                AppAssets.MARKET_PLACE_NAVBAR_ICON,
                                height: 16,
                                width: 16,
                              ),
                              CircleAvatar(
                                radius: 11,
                                backgroundColor:
                                    const Color.fromARGB(255, 45, 185, 185),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                      getFormatedProfileUrl(LoginCredential()
                                              .getUserData()
                                              .profile_pic ??
                                          '')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: Get.height - 149.5,
                      width: Get.width,
                      child: const TabBarView(
                        children: [
                          HomeView(),
                          VideoView(),
                          FriendView(),
                          NotificationView(),
                          CartView(),
                          MarketplaceView(),
                          UserMenuView()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
