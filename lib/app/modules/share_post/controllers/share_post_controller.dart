import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/snackbar.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';

class SharePostController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  late UserModel userModel;
  late TextEditingController descriptionController;
  static const List<String> list = [
    'Public',
    'Friends',
    'Only Me',
  ];

  RxString dropdownValue = list.first.obs;
  RxString postPrivacy = 'public'.obs;

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
    descriptionController = TextEditingController();
    userModel = _loginCredential.getUserData();
    super.onInit();
  }


}
