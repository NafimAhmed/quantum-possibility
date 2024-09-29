import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/login_creadential.dart';
import '../../../../models/api_response.dart';
import '../../../../models/notification.dart';
import '../../../../services/api_communication.dart';

class NotificationController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  Rx<List<NotificationModel>> notificationList = Rx([]);
  RxBool isNotificationLoading = false.obs;


  Future getNotifications() async {

    isNotificationLoading.value = true;

    final ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: 'data',
      apiEndPoint:
          'get-all-user-specific-notifications/${_loginCredential.getUserData().id}',
    );
    if (apiResponse.isSuccessful) {
      isNotificationLoading.value = false;
      notificationList.value = (apiResponse.data as List)
          .map((element) => NotificationModel.fromMap(element))
          .toList();
      debugPrint(apiResponse.data.toString());
    } else {
      isNotificationLoading.value = false;
      debugPrint(apiResponse.message.toString());
    }
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
    getNotifications();
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    super.onClose();
  }
}
