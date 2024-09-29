import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/button.dart';
import '../../../../components/image.dart';
import '../../../../config/app_assets.dart';
import '../../../../data/login_creadential.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/image.dart';
import '../controllers/user_menu_controller.dart';

class UserMenuView extends GetView<UserMenuController> {
  const UserMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //====================================================== Menu & Search Section ======================================================//

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.search,
                  size: 30,
                )
              ],
            ),
            //====================================================== Profile Card ======================================================//

            InkWell(
              onTap: () {
                Get.toNamed(Routes.PROFILE);

              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      NetworkCircleAvatar(
                          imageUrl: getFormatedProfileUrl(
                              controller.model.profile_pic ?? '')),
                      const SizedBox(width: 10),
                      Text(
                        '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            //====================================================== User Properties Section ======================================================//

            UserPropertyCard(asset: AppAssets.GROUP_ICON, title: 'Group'),
            UserPropertyCard(asset: AppAssets.PAGE_ICON, title: 'Page'),
            UserPropertyCard(asset: AppAssets.GROUP_ICON, title: 'Ads Manager'),
            UserPropertyCard(
                asset: AppAssets.MARKET_PLACE_ICON, title: 'Marketplace'),
            UserPropertyCard(asset: AppAssets.GROUP_ICON, title: 'Video'),
            const SizedBox(height: 10),
            PrimaryButton(
              verticalPadding: 15,
              onPressed: () {},
              text: 'See More',
              backgroundColor: Colors.grey.shade400,
              textColor: Colors.black,
              fontSize: 14,
            ),
            const SizedBox(height: 10),
            //====================================================== Setting Section ======================================================//

            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    UserSettingCard(
                        iconData: Icons.settings_outlined,
                        title: 'Settings & privacy',
                        onTap: () {}),
                    const SizedBox(height: 15),
                    UserSettingCard(
                        iconData: Icons.settings_outlined,
                        title: 'Give us Feedback',
                        onTap: () {}),
                    const SizedBox(height: 15),
                    UserSettingCard(
                        iconData: Icons.settings_outlined,
                        title: 'Sign Out',
                        onTap: controller.onTapSignOut),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget UserPropertyCard({
    required String asset,
    required String title,
  }) {
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          Image(
            height: 64,
            width: 64,
            image: AssetImage(
              asset,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget UserSettingCard({
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData, size: 28),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
