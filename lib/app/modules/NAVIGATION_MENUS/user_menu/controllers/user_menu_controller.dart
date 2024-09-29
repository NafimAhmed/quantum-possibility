import 'package:get/get.dart';

import '../../../../data/login_creadential.dart';
import '../../../../models/user.dart';
import '../../../../routes/app_pages.dart';

class UserMenuController extends GetxController {
  late final LoginCredential _loginCredential;
  late UserModel model;

  void onTapSignOut() {
    _loginCredential.clearLoginCredential();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    _loginCredential = LoginCredential();
    model = _loginCredential.getUserData();
    super.onInit();
  }
}
