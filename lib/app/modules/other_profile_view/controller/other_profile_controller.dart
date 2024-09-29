import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../../models/friend.dart';
import '../../../models/post.dart';
import '../../../models/profile_model.dart';
import '../../../services/api_communication.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/models/photos_model.dart';
import '../../NAVIGATION_MENUS/user_menu/profile/models/story_model.dart';

class OthersProfileController extends GetxController {
  Rx<List<PhotoModel>> photoList = Rx([]);
  Rx<List<ProfilrStoryModel>> storyList = Rx([]);
  Rx<ProfileModel?> profileModel = Rx(null);
  Rx<List<FriendModel>> friendList = Rx([]);

  RxBool isLoadingFriendList = true.obs;

  RxInt viewNumber = 0.obs;
  //UserModel? userModel;
  // RxBool isLoading = true.obs;
  RxBool isLoadingNewsFeed = true.obs;
  late ApiCommunication _apiCommunication;
  late UserModel userModel;
  late TextEditingController commentController;

  Rx<List<PostModel>> postList = Rx([]);

  //UserIdModel othetUserModel = Get.arguments;
  String username = '${Get.arguments}';

  Future getOtherUserData() async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'get-user-info',
      requestData: {'username': username},
      responseDataKey: 'userInfo',
    );
    if (apiResponse.isSuccessful) {
      debugPrint('Response success');
      profileModel.value =
          ProfileModel.fromMap(apiResponse.data as Map<String, dynamic>);
      debugPrint('Response success');
    }
  }

  Future getOtherPhotos() async {
    debugPrint('==========================get Photo Start');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'get-users-latest-image',
        requestData: {'username': username},
        responseDataKey: 'images');

    debugPrint('==========================get Photo After api call');
    if (apiResponse.isSuccessful) {
      debugPrint('==========================get Photo Before Model');
      debugPrint('Response success');
      photoList.value = (apiResponse.data as List)
          .map(
            (e) => PhotoModel.fromMap(e),
          )
          .toList();
      debugPrint('Response success');
      debugPrint('==========================get Photo After model');
    }
  }

  Future getOtherStoris() async {
    debugPrint('==========================get Story Start');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'get-users-latest-story',
        requestData: {'username': username},
        responseDataKey: 'storylist');

    debugPrint('==========================get Story After api call');
    if (apiResponse.isSuccessful) {
      debugPrint('==========================get Story Before Model');
      debugPrint('Response success');
      storyList.value = (apiResponse.data as List)
          .map(
            (e) => ProfilrStoryModel.fromMap(e),
          )
          .toList();
      debugPrint('Response success');
      debugPrint('==========================get Story After model');
    }
  }

  // void getOtherUserData() async {
  //   isLoading.value = true;
  //   ApiCommunication apiUserDataCommunication = ApiCommunication();
  //
  //   ApiResponse response = await apiUserDataCommunication.doPostRequest(
  //     apiEndPoint: 'get-user-info',
  //     requestData: {
  //       'username': '${othetUserModel.username}',//'anik.ba',
  //     },
  //     responseDataKey: ApiConstant.FULL_RESPONSE,
  //   );
  //
  //   if (response.isSuccessful) {
  //     userModel = UserModel.fromMap((response.data as Map)['userInfo']);
  //     isLoading.value = false;
  //   } else {
  //     isLoading.value = true;
  //   }
  //
  //   debugPrint('=============getOtherUserData==============$response');
  // }

  Future<void> getPosts(String user) async {
    isLoadingNewsFeed.value = true;

    const int pageSize = 10;
    int totalPageCount = 0;

    final apiResponse = await _apiCommunication.doPostRequest(
      requestData: {
        'username': user //"anik.ba"
      },
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint:
          'get-all-users-posts-individual?username=$username&pageNo=1&pageSize=70',
    );
    isLoadingNewsFeed.value = false;

    debugPrint(
        '=============Other Post response==================$apiResponse');

    if (apiResponse.isSuccessful) {
      int totalPostCount =
          (apiResponse.data as Map<String, dynamic>)['totalPosts'];
      totalPageCount = totalPostCount ~/ pageSize;
      if (totalPostCount % pageSize != 0) totalPageCount += 1;
      postList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
              .map((element) => PostModel.fromMap(element))
              .toList());
      postList.refresh();
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }
  }

  Future commentOnPost(int index, PostModel postModel) async {
    final ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-user-comment-by-post',
      isFormData: true,
      requestData: {
        'user_id': postModel.user_id?.id,
        'post_id': postModel.id,
        'comment_name': commentController.text,
        'image_or_video': null,
        'link': null,
        'link_title': null,
        'link_description': null,
        'link_image': null
      },
    );
  }

  @override
  Future<void> refresh() async {
    await getPosts(username);
  }

  Future<void> getFriends() async {
    isLoadingFriendList.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'friend-list',
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
  Future<void> onInit() async {
    _apiCommunication = ApiCommunication();
    commentController = TextEditingController();
    userModel = LoginCredential().getUserData();
    // await getOtherPhotos();
    // await getOtherStoris();
    await getOtherUserData();
    await getPosts(username);
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
  }

  @override
  void onReady() {}
}
