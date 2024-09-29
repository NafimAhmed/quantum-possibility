import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../user_menu/profile/controllers/profile_controller.dart';
import '../../../../utils/color.dart';

import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/firend_request.dart';
import '../../../../models/friend.dart';
import '../../../../services/api_communication.dart';
import '../../../../utils/snackbar.dart';
import '../model/people_may_you_khnow.dart';

class FriendController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential loginCredential;
  Rx<List<FriendRequestModel>> friendRequestList = Rx([]);
  Rx<List<FriendModel>> friendList = Rx([]);
  Rx<List<PeopleMayYouKnowModel>> peopleMayYouKnowModelList = Rx([]);
  RxBool isLoadingNewsFeed = true.obs;
  Rx<int> viewType = 1.obs; // 1= Friend Request View, 2 = My Connection View
  Rx<bool> isFriendVisible = false.obs;
  Rx<bool> isRequestVisible = true.obs;

  ProfileController profileController = Get.put(ProfileController());

  Future<void> getFriends() async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'friend-list',
      requestData: {
        'username': loginCredential.getUserData().username,
      },
    );
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      friendList.value =
          (((apiResponse.data as Map<String, dynamic>)['results']) as List)
              .map((element) => FriendModel.fromMap(element))
              .toList();
      friendList.refresh();
      debugPrint(friendList.value.length.toString());
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> blockFriends(String userId) async {
    debugPrint('===============================================Block Start');

    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'settings-privacy/block-user',
        requestData: {
          'block_user_id': userId,
        },
        enableLoading: true,
        errorMessage: 'block failed');

    debugPrint(
        '===============================================Block API Call End');

    if (apiResponse.isSuccessful) {
      getFriends();
      friendList.refresh();

      profileController.getFriends();
      profileController.friendList.refresh();

      Get.snackbar('Success', 'Successfully Blocked',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PRIMARY_COLOR);
      debugPrint(
          '===============================================Block Successs');
    } else {
      debugPrint('===============================================Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> unfriendFriends(String userId) async {
    debugPrint('===============================================Block Start');

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'unfriend-user',
      requestData: {
        'requestId': userId,
      },
      enableLoading: true,
      errorMessage: 'Unfriend failed',
    );

    debugPrint(
        '===============================================Block API Call End');

    if (apiResponse.isSuccessful) {
      getFriends();
      // friendList.refresh();

      profileController.getFriends();
      profileController.friendList.refresh();

      Get.snackbar('Success', 'Successfully Unfriend',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PRIMARY_COLOR);
      debugPrint(
          '===============================================Block Successs');
    } else {
      debugPrint('===============================================Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }



  Future<void> reportFriends(String userId) async {
    debugPrint('===============================================Block Start');

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'unfriend-user',
      requestData: {
        'requestId': userId,
      },
      enableLoading: true,
      errorMessage: 'Unfriend failed',
    );

    debugPrint(
        '===============================================Block API Call End');

    if (apiResponse.isSuccessful) {
      getFriends();
      // friendList.refresh();

      profileController.getFriends();
      profileController.friendList.refresh();

      Get.snackbar('Success', 'Successfully Unfriend',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: PRIMARY_COLOR);
      debugPrint(
          '===============================================Block Successs');
    } else {
      debugPrint('===============================================Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }







  Future<void> getFriendRequestes() async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'friend-request-list',
    );
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      friendRequestList.value =
          (((apiResponse.data as Map<String, dynamic>)['results']) as List)
              .map((element) => FriendRequestModel.fromMap(element))
              .toList();
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> getPeopleMayYouKnow() async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: 'userlist',
      apiEndPoint: 'suggestion-list',
    );
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      peopleMayYouKnowModelList.value = (apiResponse.data as List)
          .map((element) => PeopleMayYouKnowModel.fromMap(element))
          .toList();
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  void sendFriendRequest({
    required int index,
    required String userId,
  }) async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'send-friend-request',
        requestData: {
          'connected_user_id': userId,
        });
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      //Action on success
      peopleMayYouKnowModelList.value.removeAt(index);
      peopleMayYouKnowModelList.refresh();
      debugPrint('');
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  void actionOnFriendRequest({
    required int action, // 0 = reject, 1 = accpet
    required String requestId,
  }) async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'friend-accept-friend-request',
        requestData: {'request_id': requestId, 'accept_reject_ind': action});
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      getFriendRequestes();
      getFriends();
      showSuccessSnackkbar(message: 'Friend request accepted successfully');
    } else {
      debugPrint('Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    loginCredential = LoginCredential();
    getFriendRequestes();
    getPeopleMayYouKnow();
    getFriends();

    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    super.onClose();
  }
}
