import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/api_response.dart';
import '../../../../services/api_communication.dart';
import '../model/reels_comment_model.dart';
import '../model/reels_model.dart';

class VideoController extends GetxController {
  late ApiCommunication _apiCommunication;
  LoginCredential loginCredential = LoginCredential();

  Rx<Color> reactionColor = Colors.white.obs;

  Rx<List<ReelsModel>> reelsModelList = Rx([]);

  var reelsCommentModl = ReelsCommentModel().obs;

  RxBool isLoading = true.obs;
  RxBool isCommentLoading = true.obs;

  Future<void> getReels() async {
    isLoading.value = true;

    ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'all-user-reels',
      responseDataKey: 'all_reels',
    );
    if (response.isSuccessful) {
      reelsModelList.value =
          (response.data as List).map((e) => ReelsModel.fromMap(e)).toList();
      isLoading.value = false;
      debugPrint(reelsModelList.value.length.toString());
    }
  }

  void reelsLike(String postId, int index) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-reaction-reel-post',
        requestData: {
          'reaction_type': 'like',
          'post_id': postId,
          'post_single_item_id': null
        });

    if (apiResponse.isSuccessful) {
      ReelsModel reelsModel =
          ReelsModel.fromMap(apiResponse.data as Map<String, dynamic>);
      reelsModelList.value[index] = reelsModel;
      reelsModelList.refresh();
    }
  }

  void reelsComments(String postId, String comment, int index) async {
    ApiResponse apiResponse = await ApiCommunication()
        .doPostRequest(apiEndPoint: 'save-user-comment-by-reel', requestData: {
      'user_id': loginCredential.getUserData().id,
      'post_id': postId,
      'comment_name': comment
    });

    if (apiResponse.isSuccessful) {
      reelsModelList.value[index].comment_count =
          (reelsModelList.value[index].comment_count ?? 0) + 1;
      reelsModelList.refresh();
      getReelCommentList(postId);
    }
  }

  void reelsCommentsReply(
    String comment_id,
    String replies_user_id,
    String replies_comment_name,
    String post_id,
  ) async {
    ApiResponse apiResponse = await ApiCommunication()
        .doPostRequest(apiEndPoint: 'reply-comment-by-reel-post', requestData: {
      'comment_id': comment_id,
      'replies_user_id': replies_user_id,
      'replies_comment_name': replies_comment_name,
      'post_id': post_id,
    });

    debugPrint(
        '=================Reels Comment reply uploader====================$apiResponse');
    if (apiResponse.isSuccessful) {
      debugPrint(
          '=================Reels Comment reply uploader if success====================$apiResponse');

      getReels();
      getReelCommentList(post_id);
    }
  }

  Future<ReelsCommentModel> getReelCommentList(String postId) async {
    isCommentLoading.value = true;

    final url = Uri.parse(
        '${ApiConstant.SERVER_IP_PORT}/api/get-all-comments-direct-reel/$postId');

    debugPrint(
        '-------------Reel comment list start--------------------$postId');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);

      debugPrint(
          '-------------Reel comment response before--------------------${response.body}');
      reelsCommentModl.value = reelsCommentModelFromJson(response.body);

      debugPrint(
          '-------------Reel comment response after--------------------${reelsCommentModl.value}');
      debugPrint(
          '-------------Reel comment response after--------------------${response.body}');
      isCommentLoading.value = false;

      //reelCommentList.value.add(reelsCommentModelFromJson(response.body));

      return reelsCommentModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw const HttpException('getCustomerAddressData Error');
    } else {
      throw const HttpException('getCustomerAddressData Error');
    }
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    getReels();
    super.onInit();
  }
}
