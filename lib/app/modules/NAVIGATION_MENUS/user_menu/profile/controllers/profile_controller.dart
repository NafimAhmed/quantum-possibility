// import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:image_picker/image_picker.dart';
import 'package:quantum_possibilities_flutter/app/models/profile_model.dart';
import 'package:quantum_possibilities_flutter/app/models/story.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/user_menu/profile/models/photos_model.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/user_menu/profile/provider/profile_provider.dart';
import 'package:quantum_possibilities_flutter/app/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import '../../../../../config/api_constant.dart';
import '../../../../../data/login_creadential.dart';
import '../../../../../models/api_response.dart';
import '../../../../../models/comment_model.dart';
import '../../../../../models/friend.dart';
import '../../../../../models/post.dart';
import '../../../../../models/user.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/api_communication.dart';
import '../models/story_model.dart';
import '../models/user_profile_model.dart';

class ProfileController extends GetxController {
  late ScrollController listScrollController;
  late ScrollController mainPageScrollController;
  late final ApiCommunication _apiCommunication;
  int totalPageCount = 0;

  RxBool isNextPage = false.obs;

  int pageNo = 1;
  final int pageSize = 50;

  Rx<List<FriendModel>> friendList = Rx([]);

  late ScrollController postScrollController;

  RxBool isLoadingRefresh = false.obs;

  var profileUserData = ProfileUserData().obs;

  RxBool isLoadingPost = true.obs;

  final LoginCredential _loginCredential = LoginCredential();

  ProfileProvider profileProvider = ProfileProvider();

  RxBool profilepicLoader = false.obs;
  RxBool coverpicLoader = false.obs;

  RxInt viewNumber = 0.obs;
  RxString selectedPrivacyOption = 'public'.obs;

  RxBool isLoadingFriendList = true.obs;

  RxBool isLoadingNewsFeed = true.obs;
  Rx<List<PostModel>> postList = Rx([]);
  late final LoginCredential loginCredential;
  late final UserModel userModel;
  late TextEditingController commentController;
  Rx<ProfileModel?> profileModel = Rx(null);
  Rx<PhotoModel?> photoModel = Rx(null);
  Rx<List<PhotoModel>> photoList = Rx([]);
  Rx<List<ProfilrStoryModel>> storyList = Rx([]);

  Future getUserData() async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'get-user-info',
      requestData: {'username': '${loginCredential.getUserData().username}'},
      responseDataKey: 'userInfo',
    );
    if (apiResponse.isSuccessful) {
      debugPrint('Response success');
      profileModel.value =
          ProfileModel.fromMap(apiResponse.data as Map<String, dynamic>);
      debugPrint('Response success');
    }
  }

  Future getPhotos() async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'get-users-latest-image',
      requestData: {'username': '${loginCredential.getUserData().username}'},
      responseDataKey: 'images',
    );

    if (apiResponse.isSuccessful) {
      photoList.value = (apiResponse.data as List)
          .map(
            (e) => PhotoModel.fromMap(e),
          )
          .toList();
    }
  }

  Future getStoris() async {
    debugPrint('==========================get Story Start');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'get-users-latest-story',
        requestData: {'username': '${loginCredential.getUserData().username}'},
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

  Future<void> getPosts() async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint:
          'get-all-users-posts-individual?pageNo=$pageNo&pageSize=$pageSize',
      requestData: {
        'username': userModel.username,
      },
    );
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      int totalPostCount =
          (apiResponse.data as Map<String, dynamic>)['totalPosts'];
      totalPageCount = totalPostCount ~/ pageSize;

      if (isNextPage.value == true) {
        if (totalPostCount % pageSize != 0) totalPageCount += 1;
        isNextPage.value = false;
      } else {
        pageNo = 1;
      }

      postList.value =
          (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
              .map((element) => PostModel.fromMap(element))
              .toList();
      postList.refresh();
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
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

    if (apiResponse.isSuccessful) {
      if (postList.value[index].comments != null) {
        postList.value[index].comments!.add(
            CommentModel.fromMap(apiResponse.data as Map<String, dynamic>));
        postList.refresh();
        commentController.clear();
        debugPrint('Hello');
      }
    } else {
      debugPrint('Failure');
    }
  }

  Future<void> deletePost(String postId) async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'delete-post-by-id',
      requestData: {
        'postId': postId,
      },
    );
    isLoadingNewsFeed.value = false;

    debugPrint('api delete response.....${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: 'Your Post Has Been Deleted');
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> updatePost(String postId, String description) async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'edit-post',
      requestData: {
        'description': description,
        'post_Id': postId,
      },
    );
    isLoadingNewsFeed.value = false;

    debugPrint('api update response.....${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: 'Your Post Has Been Deleted');
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  Future<void> updatePostPrivacy(String postId) async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
        responseDataKey: ApiConstant.FULL_RESPONSE,
        apiEndPoint: 'edit-post',
        requestData: {
          'post_privacy': selectedPrivacyOption,
          'post_id': postId,
        },
        isFormData: true);
    isLoadingNewsFeed.value = false;

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: 'Your Post Privacy Has Been Changed');
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }

    debugPrint('-post-home controller---------------------------$apiResponse');
  }

  void onTapCreatePost() async {
    await Get.toNamed(Routes.CREAT_POST);
    pageNo = 1;
    totalPageCount = 0;
    postList.value.clear();
    getPosts();
  }

  postListScrollListener() {
    debugPrint(listScrollController.position.pixels.toString());
    if (listScrollController.position.pixels ==
        listScrollController.position.minScrollExtent) {
      mainPageScrollController.animateTo(
        mainPageScrollController.offset - 250,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> profilePicUpload() async {
    final XFile? response = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 5));
    if (response != null) {
      profilepicLoader.value = true;

      String imgPath = await profileProvider.profileImageUpload(
          response.path, File(response.path));
      //profilePicURL.value ='$IMAGE_BASE_URL$imgPath';
      //await getStorage.write("profile_picture", "$imgPath");

      profilepicLoader.value = false;
    } else {
      //return null;
    }
  }

  Future<void> coverPicUpload() async {
    final XFile? response = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 5));
    if (response != null) {
      coverpicLoader.value = true;

      String imgPath = await profileProvider.coverImageUpload(
          response.path, File(response.path));
      //profilePicURL.value ='$IMAGE_BASE_URL$imgPath';
      //await getStorage.write("profile_picture", "$imgPath");

      coverpicLoader.value = false;
    } else {
      //return null;
    }
  }

  void getUserDataRefresh() async {
    isLoadingRefresh.value = true;
    ApiCommunication apiUserDataCommunication = ApiCommunication();

    ApiResponse response = await apiUserDataCommunication.doPostRequest(
      apiEndPoint: 'get-user-info',
      requestData: {
        'username': '${_loginCredential.getUserData().username}', //'anik.ba',
      },
      responseDataKey: ApiConstant.FULL_RESPONSE,
    );

    if (response.isSuccessful) {
      userModel = UserModel.fromMap((response.data as Map)['userInfo']);

      _loginCredential.saveUserData(userModel);
      isLoadingRefresh.value = false;
    } else {
      isLoadingRefresh.value = true;
    }

    debugPrint('=============getOtherUserData==============$response');
  }

  Future<void> reactOnPost({
    required PostModel postModel,
    required String reaction,
    required int index,
  }) async {
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'save-reaction-main-post',
      requestData: {
        'reaction_type': reaction,
        'post_id': postModel.id,
        'post_single_item_id': null,
      },
    );

    if (apiResponse.isSuccessful) {
      // updateReactionLocally(
      //     index: index, postId: postModel.id ?? '', reaction: reaction);
      debugPrint(apiResponse.message);
      updatePostList(postModel.id ?? '', index);
    } else {
      debugPrint(apiResponse.message);
    }
  }

  void _scrollListener() async {
    if (postScrollController.position.pixels ==
        postScrollController.position.maxScrollExtent) {
      if (pageNo != totalPageCount) {
        //pageNo += 1;
        isNextPage.value = true;
        await getPosts();
        isNextPage.value = false;
      }
    }
  }

  Future<void> updatePostList(String postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'view-single-main-post-with-comments/$postId',
      responseDataKey: 'post',
    );
    if (apiResponse.isSuccessful) {
      List<PostModel> postmodelList =
          (apiResponse.data as List).map((e) => PostModel.fromMap(e)).toList();
      postList.value[index] = postmodelList.first;
      postList.refresh();
    }
  }

  Future<void> getFriends() async {
    isLoadingFriendList.value = true;

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'friend-list',
      requestData: {
        'username': loginCredential.getUserData().username,
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
  void onInit() async {
    listScrollController = ScrollController();
    mainPageScrollController = ScrollController();
    _apiCommunication = ApiCommunication();

    loginCredential = LoginCredential();
    userModel = loginCredential.getUserData();
    commentController = TextEditingController();

    postScrollController = ScrollController();
    await getUserData();
    await getPosts();
    super.onInit();
  }

  @override
  void onReady() {
    listScrollController.addListener(postListScrollListener);

    postScrollController.addListener(_scrollListener);
    super.onReady();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    listScrollController.dispose();
    super.onClose();
  }

  void onTapEditPost(PostModel model) async {
    await Get.toNamed(Routes.EDIT_POST, arguments: model);
    pageNo = 1;
    totalPageCount = 0;
    postList.value.clear();
    getPosts();
  }

}
