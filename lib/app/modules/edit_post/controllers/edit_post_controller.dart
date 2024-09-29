import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/api_constant.dart';
import '../../../data/post_color_list.dart';
import '../../../models/MediaTypeModel.dart';
import '../../../models/api_response.dart';
import '../../../models/feeling_model.dart';
import '../../../models/friend.dart';
import '../../../models/location_model.dart';
import '../../../models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_communication.dart';
import '../../../utils/snackbar.dart';
import '../../NAVIGATION_MENUS/friend/controllers/friend_controller.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';

class EditPostController extends GetxController {

  late ApiCommunication _apiCommunication;

  RxString eventType = 'work'.obs;
  RxString eventSubType = ''.obs;
  RxString orgName = ''.obs;
  RxString designation = ''.obs;
  RxString startDate = 'start date'.obs;
  RxString endDate = 'end date'.obs;
  RxBool is_current_working = false.obs;

  RxString postId = ''.obs;
  var feelingId = ''.obs;
  var activityId = ''.obs;
  var subActivityId = ''.obs;
  RxString userId = ''.obs;
  RxString postType = 'timeline_post'.obs;
  var postBackgroundColor = ''.obs;
  var locationId = ''.obs;
  RxString postPrivacy = ''.obs;

  RxBool isLoading = false.obs;

  static const List<String> list = [
    'public',
    'friends',
    'only_me',
  ];

  RxString dropdownValue = list.first.obs;

  TextEditingController descriptionController = TextEditingController();

  Rx<List<XFile>> xfiles = Rx([]);

  Rx<List<MediaTypeModel>> imageFromNetwork = Rx([]);

  Rx<List<String>> removeMediaId = Rx([]);

  Rx<List<User>> checkFriendList = Rx([]);
  Rx<List<FriendModel>> searchFriendList = Rx([]);
  FriendController friendController =  Get.put(FriendController());
  var tagPeopleController = ''.obs;

  var feelingController = ''.obs;
  RxBool isFeelingLoading = false.obs;
  Rx<List<PostFeeling>> feelingList = Rx([]);
  Rx<List<PostFeeling>> feelingSearchList = Rx([]);
  Rx<PostFeeling?> feelingName = Rx(null);
  RxString locationSearch = ''.obs;
  Rx<List<AllLocation>> locationList = Rx([]);
  RxBool isLocationLoading = false.obs;
  Rx<AllLocation?> locationName = Rx(null);

  RxBool isTapped = false.obs;
  Rx<Color> textInputColor = postListColor.first.obs;


  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    getFeeling();
    getLocation();
    friendController.getFriends();
    super.onInit();
  }

  Future<void> updateUserLifeEvent(String userName, String postId) async {
    debugPrint('Update model status code.............' 'funciton call');

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'edit-life-event',
      isFormData: true,
      requestData: {
        'event_type': eventType,
        'event_sub_type': eventSubType,
        'org_name': orgName,
        'designation': designation,
        'username': userName,
        'start_date': startDate,
        'end_date': endDate,
        'privacy': postPrivacy,
        'post_id': postId,
      },
    );

    debugPrint(
        'Update model status code.............${apiResponse.statusCode}');

    debugPrint(
        'Update model status success.............${apiResponse.isSuccessful}');

    debugPrint('Update model status  msg.............${apiResponse.message}');

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: apiResponse.message ?? 'Error');
      ProfileController profileController = Get.find();
      Get.toNamed(Routes.PROFILE);
      await profileController.getPosts();
    } else {}
  }

  Future<void> updateUserPost() async {
    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'edit-post',
        isFormData: true,
        enableLoading: true,
        requestData: {
          'post_id': postId,
          'description': descriptionController.text,
          'feeling_id': feelingId,
          'activity_id': activityId,
          'sub_activity_id': subActivityId,
          'user_id': userId,
          'post_type': postType,
          'post_background_color': postBackgroundColor,
          'location_id': locationId,
          'post_privacy': postPrivacy,
          'tags': checkFriendList.value
              .map((checkFriend) => checkFriend!.id.toString())
              .toList(),
          'removable_file_ids': removeMediaId.value
        },
        mediaXFiles: xfiles.value);

    if (apiResponse.isSuccessful) {
      Get.back();
      showSuccessSnackkbar(message: apiResponse.message ?? 'Error');

    } else {}
  }

  Future<void> pickFiles() async {
    isLoading.value = true;
    final ImagePicker picker = ImagePicker();
    xfiles.value = await picker.pickMultipleMedia();
    for (int index = 0; index < xfiles.value.length; index++) {
      imageFromNetwork.value.add(
          MediaTypeModel(imagePath: xfiles.value[index].path, isFile: true));

      isLoading.value = false;
    }
  }

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
}
