



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:quantum_possibilities_flutter/app/services/api_communication.dart';

import '../../../config/api_constant.dart';
import '../../../models/friend.dart';

class OtherProfileFriendController extends GetxController{


  String username = Get.arguments;

  RxString searchString=''.obs;

  RxString searchCont = "".obs;








  RxBool isLoadingFriendList = true.obs;
  late ApiCommunication _apiCommunication;
  Rx<List<FriendModel>> friendList = Rx([]);
  Rx<List<FriendModel>> friendSearchList = Rx([]);



  void freiendSearch (String search){

    friendSearchList.value.clear();

    for(int i=0; i<friendList.value.length;i++)
      {


        if('${friendList.value[i].user_id?.first_name} ${friendList.value[i].user_id?.last_name}'.contains(search))
       { friendSearchList.value.add(friendList.value[i]);}



      }

    friendList.value=friendSearchList.value;
    friendList.refresh();

  }



  Future<void> getFriends() async {
    isLoadingFriendList.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'friend-list',
      enableLoading: true,
      requestData: {
        'username': username,
      },
    );
    isLoadingFriendList.value = false;

    if (apiResponse.isSuccessful) {
      friendList.value =
          (((apiResponse.data as Map<String, dynamic>)['results']) as List)
              .map((element) => FriendModel.fromMap(element))
              .toList();
      debugPrint(friendList.value.length.toString());
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
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
    getFriends();

  }
}