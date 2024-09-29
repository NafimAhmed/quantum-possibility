import 'package:get/get.dart';

import '../../NAVIGATION_MENUS/cart/controllers/cart_controller.dart';
import '../../NAVIGATION_MENUS/friend/controllers/friend_controller.dart';
import '../../NAVIGATION_MENUS/home/controllers/home_controller.dart';
import '../../NAVIGATION_MENUS/marketplace/controllers/marketplace_controller.dart';
import '../../NAVIGATION_MENUS/notification/controllers/notification_controller.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';
import '../../NAVIGATION_MENUS/video/controllers/video_controller.dart';

class LandingController extends GetxController {
  final Rx<int> _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  initializeAllBottomNavigationItemsController() {
    Get.put(HomeController());
    Get.put(VideoController());
    Get.put(FriendController());
    Get.put(NotificationController());
    Get.put(CartController());
    Get.put(MarketplaceController());
    Get.put(ProfileController());
  }

  void changeIndex(int index) {
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    initializeAllBottomNavigationItemsController();
    super.onInit();
  }
}
