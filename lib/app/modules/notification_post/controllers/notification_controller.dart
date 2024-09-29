import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/api_constant.dart';
import '../../../data/login_creadential.dart';
import '../../../models/api_response.dart';
import '../../../models/comment_model.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../services/api_communication.dart';

class NotificationPostController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  late UserModel userModel;
  RxBool isLoadingNewsFeed = true.obs;
  Rx<List<PostModel>> postList = Rx([]);
  late TextEditingController commentController;

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
    userModel = _loginCredential.getUserData();
    commentController = TextEditingController();
    super.onInit();
  }

  Future<void> getPosts(String postId) async {
    isLoadingNewsFeed.value = true;

    debugPrint('ivalid user code$postId');

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'view-single-main-post-with-comments/$postId',
    );
    isLoadingNewsFeed.value = false;

    debugPrint('ivalid user code$apiResponse');

    debugPrint(
        '=================Single Post Api==========================${apiResponse.data}');

    if (apiResponse.isSuccessful) {
      postList.value.clear();
      postList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['post']) as List)
              .map((element) => PostModel.fromMap(element))
              .toList());
    }
  }

  Future commentOnPost(PostModel postModel) async {
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
      if (postList.value[0].comments != null) {
        postList.value[0].comments!.add(
            CommentModel.fromMap(apiResponse.data as Map<String, dynamic>));
        postList.refresh();
        commentController.clear();
        debugPrint('Hello');
      }
    } else {
      debugPrint('Failure');
    }
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    super.onClose();
  }
}
