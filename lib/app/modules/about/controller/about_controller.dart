



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/login_creadential.dart';
import '../../../models/api_response.dart';
import '../../../models/profile_model.dart';
import '../../../services/api_communication.dart';

class AboutController extends GetxController{



  late final ApiCommunication _apiCommunication;
  late final LoginCredential loginCredential;
  Rx<ProfileModel?> profileModel = Rx(null);


  Future getUserALLData() async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'get-user-info',
      requestData: {'username': '${loginCredential.getUserData().username}'},
      responseDataKey: 'userInfo',
    );

    debugPrint('=====================Response about');



    if (apiResponse.isSuccessful) {
      debugPrint('=====================Response success');
      profileModel.value = ProfileModel.fromMap(apiResponse.data as Map<String, dynamic>);
      debugPrint('========================Response success');
    }
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  @override
  void onInit() {

    _apiCommunication=ApiCommunication();
    loginCredential=LoginCredential();
    getUserALLData();
  }
}