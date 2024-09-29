import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quantum_possibilities_flutter/app/data/post_color_list.dart';

import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/api_response.dart';
import '../../../../models/feeling_model.dart';
import '../../../../models/friend.dart';
import '../../../../models/location_model.dart';
import '../../../../models/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_communication.dart';
import '../../../../utils/snackbar.dart';
import '../../../NAVIGATION_MENUS/friend/controllers/friend_controller.dart';
import '../../../NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';

class CreatePostController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  late UserModel userModel;
  late TextEditingController descriptionController;
  var feelingController = ''.obs;
  var tagPeopleController = ''.obs;

  RxBool isTapped = false.obs;
  Rx<Color> textInputColor = postListColor.first.obs;

  String splitString(String colorCode) {
    String temp = colorCode.substring(2, 8);
    return temp;
  }

  static const List<String> list = [
    'public',
    'friends',
    'only_me',
  ];
  // For Background color post view
  Rx<bool> isBackgroundColorPost = false.obs;

  RxString eventType = 'work'.obs;
  RxString eventSubType = ''.obs;
  RxString orgName = ''.obs;
  RxString designation = ''.obs;
  Rx<String?> startDate = Rx(null);
  Rx<String?> endDate = Rx(null);
  RxBool is_current_working = false.obs;

  RxString dropdownValue = list.first.obs;

  Rx<List<XFile>> xfiles = Rx([]);

  Rx<List<PostFeeling>> feelingList = Rx([]);
  Rx<List<PostFeeling>> feelingSearchList = Rx([]);

  RxBool isFeelingLoading = false.obs;
  Rx<PostFeeling?> feelingName = Rx(null);
  Rx<AllLocation?> locationName = Rx(null);
  RxBool isLocationLoading = false.obs;
  RxString locationSearch = ''.obs;
  Rx<List<AllLocation>> locationList = Rx([]);

  late FriendController friendController;
  RxString feelingId = ''.obs;
  RxString locationId = ''.obs;

  Rx<List<FriendModel>> checkFriendList = Rx([]);

  Rx<List<FriendModel>> searchFriendList = Rx([]);

  Future<void> getFeeling() async {
    isFeelingLoading.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-feelings',
    );
    isFeelingLoading.value = false;

    if (apiResponse.isSuccessful) {
      feelingList.value =
          (((apiResponse.data as Map<String, dynamic>)['postFeelings']) as List)
              .map((element) => PostFeeling.fromJson(element))
              .toList();
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> getLocation() async {
    isLocationLoading.value = true;
    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'search-location',
      responseDataKey: ApiConstant.FULL_RESPONSE,
      requestData: {
        'searchTerm': locationSearch.value,
      },
    );
    isLocationLoading.value = false;
    if (response.isSuccessful) {
      locationList.value =
          (((response.data as Map<String, dynamic>)['allLocation']) as List)
              .map((element) => AllLocation.fromJson(element))
              .toList();
    } else {
      debugPrint('');
    }
  }

  Future<void> onTapCreatePost() async {
    var postColorCode = textInputColor.value;

    var hex = postColorCode.value.toRadixString(16);

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-post',
      isFormData: true,
      enableLoading: true,
      requestData: {
        'description': descriptionController.text,
        'feeling_id': feelingId.value,
        'activity_id': '',
        'sub_activity_id': '',
        'user_id': userModel.id,
        'post_type': 'timeline_post',
        'location_id': locationId.value,
        'post_privacy': (getPostPrivacy(dropdownValue.value)),
        'post_background_color': splitString(hex),
        'event_type': '',
        'event_sub_type': '',
        'org_name': '',
        'start_date': '',
        'end_date': '',
        'tags': checkFriendList.value
            .map((checkFriend) => checkFriend.user_id!.id.toString())
            .toList()
      },
      mediaXFiles: xfiles.value,
    );
    if (response.isSuccessful) {
      Get.back();
      showSuccessSnackkbar(message: 'Post submitted successfully');
    } else {
      debugPrint('');
    }
  }

  Future<void> onTapCreateEventPost() async {
    debugPrint('org name ............$orgName');
    debugPrint('end date ............$endDate');
    debugPrint('end date ............$startDate');

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-post',
      isFormData: true,
      enableLoading: true,
      requestData: {
        'description': '',
        'feeling_id': '',
        'activity_id': '',
        'sub_activity_id': '',
        'user_id': userModel.id,
        'post_type': 'timeline_post',
        'location_id': '',
        'post_privacy': (getPostPrivacy(dropdownValue.value)),
        'post_background_color': '',
        'event_type': eventType.value,
        'event_sub_type': eventSubType.value,
        'org_name': orgName.value,
        'designation': designation.value,
        'start_date': startDate.value ?? '',
        'end_date': endDate.value ?? '',
        'is_current_working': is_current_working
      },
      mediaXFiles: xfiles.value,
    );
    if (response.isSuccessful) {
      eventType = 'work'.obs;
      eventSubType = ''.obs;
      orgName.value = '';
      designation.value = '';
      startDate.value = '';
      endDate.value = '';
      is_current_working.value = false;

      ProfileController controller = Get.find();
      controller.getPosts();
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      showSuccessSnackkbar(message: 'Post submitted successfully');
    } else {
      debugPrint('');
    }
  }

  String getPostPrivacy(String value) {
    switch (value) {
      case 'Public':
        return 'public';
      case 'Friends':
        return 'friends';
      case 'Only Me':
        return 'only_me';
      default:
        return 'public';
    }
  }

  Future<void> pickFiles() async {
    final ImagePicker picker = ImagePicker();
    xfiles.value = await picker.pickMultipleMedia();
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
    descriptionController = TextEditingController();
    userModel = _loginCredential.getUserData();
    friendController = Get.find();
    friendController.getFriends();
    getFeeling();
    getLocation();
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    super.onClose();
  }
}
