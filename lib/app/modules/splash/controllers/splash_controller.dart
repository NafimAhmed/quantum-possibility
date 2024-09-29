import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/login_creadential.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  LoginCredential loginCredential = LoginCredential();
  void navigate() async {
    Timer(const Duration(seconds: 3), () {
      if (loginCredential.isUserLoggedIn()) {
        Get.offNamed(Routes.TAB);
        debugPrint('Splash Page');
        debugPrint('User Data: \n${loginCredential.getUserData()}');
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}
