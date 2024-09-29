import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quantum_possibilities_flutter/app/models/story_merge_model.dart';
import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/user_menu/profile/controllers/profile_controller.dart';
import 'package:quantum_possibilities_flutter/app/utils/snackbar.dart';
import '../../../../models/comment_reply_reaction.dart';
import '../../../../config/api_constant.dart';
import '../../../../data/login_creadential.dart';
import '../../../../models/api_response.dart';
import '../../../../models/comment_model.dart';
import '../../../../models/comment_reaction_model.dart';
import '../../../../models/post.dart';
import '../../../../models/story.dart';
import '../../../../models/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_communication.dart';

class HomeController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential loginCredential;
  late UserModel userModel;
  late TextEditingController descriptionController;

  RxBool isCommentReactionLoading = true.obs;
  RxBool isReplyReactionLoading = true.obs;
  RxInt storyCaroselInitialIndex = 0.obs;
  static const List<String> list = [
    'Public',
    'Friends',
    'Only Me',
  ];

  RxString dropdownValue = list.first.obs;
  RxString postPrivacy = 'public'.obs;

  //
  Rx<List<CommentReactions>> reactionList = Rx([]);
  Rx<List<CommentReactions>> likeList = Rx([]);
  Rx<List<CommentReactions>> loveList = Rx([]);
  Rx<List<CommentReactions>> hahaList = Rx([]);
  Rx<List<CommentReactions>> wowList = Rx([]);
  Rx<List<CommentReactions>> sadList = Rx([]);
  Rx<List<CommentReactions>> angryList = Rx([]);
  Rx<List<CommentReactions>> unlikeList = Rx([]);

  Rx<List<ReplyReactions>> replyReactionList = Rx([]);
  Rx<List<ReplyReactions>> replyLikeList = Rx([]);
  Rx<List<ReplyReactions>> replyLoveList = Rx([]);
  Rx<List<ReplyReactions>> replyHahaList = Rx([]);
  Rx<List<ReplyReactions>> replyWowList = Rx([]);
  Rx<List<ReplyReactions>> replySadList = Rx([]);
  Rx<List<ReplyReactions>> replyAngryList = Rx([]);
  Rx<List<ReplyReactions>> replyUnlikeList = Rx([]);

  Rx<List<XFile>> xfiles = Rx([]);

  RxString commentsID = ''.obs;
  RxString postID = ''.obs;

  RxBool isLoadingNewsFeed = true.obs;
  RxBool isLoadingStory = true.obs;
  Rx<List<PostModel>> postList = Rx([]);
  Rx<List<StoryModel>> storytList = Rx([]);

  late ScrollController postScrollController;
  int pageNo = 1;
  final int pageSize = 30;
  int totalPageCount = 0;
  late TextEditingController commentController;
  late TextEditingController commentReplyController;
  RxBool isReply = false.obs;

  Future<void> getPosts() async {
    isLoadingNewsFeed.value = true;

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-users-posts?pageNo=$pageNo&pageSize=$pageSize',
    );
    isLoadingNewsFeed.value = false;

    debugPrint('ivalid user code$apiResponse');

    if (apiResponse.isSuccessful) {
      int totalPostCount =
          (apiResponse.data as Map<String, dynamic>)['totalPosts'];
      totalPageCount = totalPostCount ~/ pageSize;
      if (totalPostCount % pageSize != 0) totalPageCount += 1;
      postList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['posts']) as List)
              .map((element) => PostModel.fromMap(element))
              .toList());

      debugPrint('===================Get post=================$postList===');

      postList.refresh();
    } else {}
  }

  Future<List<CommentModel>> getSinglePostsComments(String postID) async {
    isLoadingNewsFeed.value = true;

    Rx<List<CommentModel>> commentList = Rx([]);

    debugPrint(
        '==================get SinglePosts Comments=========Start==========================');

    final apiResponse = await _apiCommunication.doGetRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-all-comments-direct-post/$postID',
    );
    isLoadingNewsFeed.value = false;

    debugPrint('ivalid user code$apiResponse');

    debugPrint(
        '==================get SinglePosts Comments=========Api Call done==========================');

    if (apiResponse.isSuccessful) {
      debugPrint(
          '==================get SinglePosts Comments=========${apiResponse.data}==========================');

      commentList.value.addAll(
          (((apiResponse.data as Map<String, dynamic>)['comments']) as List)
              .map((element) => CommentModel.fromMap(element))
              .toList());

      debugPrint(
          '===================get SinglePosts Commentsn=================${commentList.value}===');

      commentList.refresh();
      return commentList.value;
    } else {
      return [];
    }
  }

  Future<void> getStories() async {
    isLoadingStory.value = true;
    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'get-story',
    );
    isLoadingStory.value = false;

    if (apiResponse.isSuccessful) {
      storytList.value =
          (((apiResponse.data as Map<String, dynamic>)['results']) as List)
              .map((element) => StoryModel.fromMap(element))
              .toList();

      debugPrint('.stroy list................${storytList.value}');
    } else {
      // showErrorSnackkbar(message: apiResponse.errorMessage ?? 'Error');
    }
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

  Future<void> reportAPost({
    required String post_id,
    required String report_type,
    required String description,
  }) async {
    debugPrint('=================Report Start==========================');

    final apiResponse = await _apiCommunication.doPostRequest(
      responseDataKey: ApiConstant.FULL_RESPONSE,
      apiEndPoint: 'save-post-report',
      enableLoading: true,
      requestData: {
        'post_id': post_id,
        'report_type': report_type,
        'description': description,
      },
    );

    debugPrint(
        '=================Report Api call end==========================');
    debugPrint(
        '=================Report Api status Code ${apiResponse.message}==========================');
    debugPrint(
        '=================Report Api success ${apiResponse.isSuccessful}==========================');

    if (apiResponse.isSuccessful) {
      debugPrint(
          '=================Report Successful==========================');

      Get.back();
      Get.back();
      Get.back();

      showSuccessSnackkbar(message: 'Post reported successfully');

      // updateReactionLocally(
      //     index: index, postId: postModel.id ?? '', reaction: reaction);
      // debugPrint(apiResponse.message);
      // updatePostList(postModel.id ?? '', index);
    } else {
      // debugPrint(apiResponse.message);
    }
  }

  Future commentOnPost(int index, PostModel postModel) async {
    debugPrint('Comment API Called============================');

    final ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-user-comment-by-post',
        isFormData: true,
        enableLoading: true,
        requestData: {
          'user_id': postModel.user_id?.id,
          'post_id': postModel.id,
          'comment_name': commentController.text,
          'link': null,
          'link_title': null,
          'link_description': null,
          'link_image': null
        },
        fileKey: 'image_or_video',
        mediaXFiles: xfiles.value);

    debugPrint('Comment API Called after api call============================');
    debugPrint(
        'Comment API Called after api call======${apiResponse.isSuccessful}======================');

    if (apiResponse.isSuccessful) {
      // postList.value.clear();
      //
      // await getPosts();
      //
      // postList.refresh();

      if (postList.value[index].comments != null) {
        postList.value[index].comments!.add(
            CommentModel.fromMap(apiResponse.data as Map<String, dynamic>));
        postList.refresh();
        commentController.clear();
        debugPrint('Hello');
        xfiles.value.clear();
      }
    } else {
      debugPrint('Failure');
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

  void onTapCreatePost() async {
    await Get.toNamed(Routes.CREAT_POST);
    ProfileController profileController = Get.find();
    profileController.pageNo = 1;
    profileController.totalPageCount = 0;
    profileController.postList.value.clear();
    profileController.getPosts();
    pageNo = 1;
    totalPageCount = 0;
    postList.value.clear();
    getPosts();
  }

  void onTapEditPost(PostModel model) async {
    await Get.toNamed(Routes.EDIT_POST, arguments: model);
    pageNo = 1;
    totalPageCount = 0;
    postList.value.clear();
    getPosts();
  }

  Future onSelectCommentReaction() async {}

  Future onSelectCommentReplayReaction() async {}

  //=========================================== For Scrolling List View

  void _scrollListener() async {
    if (postScrollController.position.pixels ==
        postScrollController.position.maxScrollExtent) {
      if (pageNo != totalPageCount) {
        pageNo += 1;
        await getPosts();
      }
    }
  }

  //=================================================================== Story
  void onTapCreateStory() {
    Get.toNamed(Routes.CREATE_STORY);
  }

  void deleteStory(String storyID) async {
    debugPrint('functiion call................');

    ApiResponse apiResponse = await ApiCommunication()
        .doPostRequest(apiEndPoint: 'delete-story', requestData: {
      'storyId': storyID,
    });

    debugPrint(
        '=================Story delet start====================$apiResponse');
    if (apiResponse.isSuccessful) {
      debugPrint(
          '=================Story delet start====================$apiResponse');
      Get.back();
      Get.back();

      // getReels();
      // getReelCommentList(post_id);
    }
  }

  void commentReply({
    required String comment_id,
    required String replies_comment_name,
    required String post_id,
    required int postIndex,
  }) async {
    debugPrint('reply function call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'reply-comment-by-direct-post',
        enableLoading: true,
        isFormData: true,
        requestData: {
          'comment_id': comment_id, //"663a15f5001ab86d881e81e7",
          'replies_user_id': userModel.id, //"6545c99d858780bf50dfc1eb",
          'replies_comment_name': replies_comment_name, //"123123",
          'post_id': post_id, //"6639e808a45d87b49746a3f0"
        },
        fileKey: 'image_or_video',
        mediaXFiles: xfiles.value);

    if (apiResponse.isSuccessful) {
      List<CommentModel> comments = await getSinglePostsComments(post_id);
      postList.value[postIndex].comments = comments;
      postList.refresh();

      // if (postList.value[postIndex].comments?[commentIndex].replies != null) {
      //   postList.value[postIndex].comments?[commentIndex].replies?.add(
      //       CommentRepliesId.fromJson(apiResponse.data as Map<String, dynamic>)
      //           as CommentReplay);
      //   postList.refresh();
      // }

      commentReplyController.text = '';

      //postList.value.clear();

      // await getPosts();

      // postList.refresh();

      xfiles.value.clear();
    }
  }

  void commentReaction(
      String reaction_type, String post_id, String comment_id) async {
    debugPrint('===================================reaction function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-comment-reaction-of-direct-post',
        requestData: {
          'reaction_type': reaction_type,
          'post_id': post_id,
          'comment_id': comment_id
        });

    debugPrint(
        '=====After API Call===========reaction function  call======${apiResponse.statusCode}====');

    if (apiResponse.isSuccessful) {
      // commentReplyController.text='';

      debugPrint(
          '=====After API Call===========reaction function  call===============');

      // List<CommentModel> comments=await getSinglePostsComments(post_id);
      // postList.value[postIndex].comments=comments;
      // postList.refresh();

      postList.value.clear();

      await getPosts();

      postList.refresh();
    }
  }

  void commentDelete(String comment_id, String post_id) async {
    debugPrint(
        '===================================Comment Delete function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'delete-single-comment',
        requestData: {
          'comment_id': comment_id,
          'post_id': post_id,
          'type': 'main_comment'
        });

    debugPrint(
        '=====After API Call===========Comment Delete function  call======${apiResponse.statusCode}====');

    if (apiResponse.isSuccessful) {
      // commentReplyController.text='';

      debugPrint(
          '=====After API Call===========Comment Delete function  call===============');

      postList.value.clear();

      await getPosts();

      postList.refresh();
    }
  }

  void replyDelete(String reply_id, String post_id) async {
    debugPrint(
        '===================================Comment Delete function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'delete-single-comment',
        requestData: {
          'comment_id': reply_id,
          'post_id': post_id,
          'type': 'reply_comment'
        });

    debugPrint(
        '=====After API Call===========Comment Delete function  call======${apiResponse.statusCode}====');

    if (apiResponse.isSuccessful) {
      // commentReplyController.text='';

      debugPrint(
          '=====After API Call===========Comment Delete function  call===============');

      postList.value.clear();

      await getPosts();

      postList.refresh();
    }
  }

  void storyViewed(String storyId) async {
    debugPrint(
        '===================================Comment Delete function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-story-view',
        requestData: {
          'story_id': storyId,
          'user_id': '${LoginCredential().getUserData().id}'
        });

    debugPrint(
        '=====After API Call===========Comment Delete function  call======${apiResponse.statusCode}====');

    if (apiResponse.isSuccessful) {
      // commentReplyController.text='';

      debugPrint('=====After API Call===========Story viewed===============');

      // postList.value.clear();
      //
      // await getPosts();
      //
      // postList.refresh();
    }
  }

  void storyReaction(String userId, String storyId, String reactionType) async {
    debugPrint('===================================Story function  call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-story-reaction',
        enableLoading: true,
        requestData: {
          'user_id': userId,
          'storyId': storyId,
          'reactionType': reactionType
        });

    debugPrint(
        '=====After API Call Story reaction=================${apiResponse.statusCode}====');

    if (apiResponse.isSuccessful) {
      // commentReplyController.text='';

      showSuccessSnackkbar(message: 'React on story Successfully');
      // await getStories();
      // storytList.refresh();

      debugPrint('=====After API Call Story Success=====================');
    }
  }

  void commentReplyReaction(String reaction_type, String comment_id,
      String replies_user_id, String post_id, String comment_replies_id) async {
    debugPrint('==========Reply Reaction3 $reaction_type==================');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-comment-reaction-of-direct-post',
        requestData: {
          'reaction_type': reaction_type, //"663a15f5001ab86d881e81e7",
          'user_id': replies_user_id, //"6545c99d858780bf50dfc1eb",//"123123",
          'post_id': post_id, //"6639e808a45d87b49746a3f0"
          'comment_id': comment_id,
          'comment_replies_id': comment_replies_id, //comment_replies_id,
        });

    debugPrint('==========Reply Reaction2 $reaction_type==================');
    debugPrint(
        '==========comment reply id===== $comment_replies_id==================');

    debugPrint(
        '==========Reply Reaction StatusCode ${apiResponse.isSuccessful}==================');

    if (apiResponse.isSuccessful) {
      debugPrint('==========Reply Reaction0 $reaction_type==================');

      postList.value.clear();

      await getPosts();

      postList.refresh();
    }
  }

  // void getReactionsIndividualComment(String postId) async {
  //   final ApiResponse response = await _apiCommunication.doPostRequest(
  //     apiEndPoint: 'reaction-user-lists-comments-of-a-direct-post',
  //     requestData: {
  //       "postId": "663ccf6589335afb22841304",
  //       "commentId": "6640578b97c7219df0ee0c5f",
  //       "commentRepliesId": null
  //     }
  //   );
  //   if (response.isSuccessful) {
  //     reactionList.value = (response.data as List)
  //         .map((element) => ReactionModel.fromMap(element))
  //         .toList();
  //     calculateReaction();
  //     debugPrint('ok');
  //   }
  // }

  void getCommentReactions(String postId, String commentId) async {
    isCommentReactionLoading.value = true;

    reactionList.value.clear();
    likeList.value.clear();
    loveList.value.clear();
    hahaList.value.clear();
    wowList.value.clear();
    sadList.value.clear();
    angryList.value.clear();
    unlikeList.value.clear();
    debugPrint('=============getCommentReactions function call===============');

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'reaction-user-lists-comments-of-a-direct-post',
      requestData: {
        'postId': postId,
        'commentId': commentId,
        'commentRepliesId': null
      },
      responseDataKey: 'reactions',
    );

    debugPrint('=============getCommentReactions List on Going===============');

    if (response.isSuccessful) {
      debugPrint('=============getCommentReactions List ok===============');

      reactionList.value = (response.data as List)
          .map((element) => CommentReactions.fromJson(element))
          .toList();
      calculateReaction();
      debugPrint('ok');

      isCommentReactionLoading.value = false;

      debugPrint(
          '=============getCommentReactions List data${reactionList.value}===============');
    }
  }

  void getCommentReplyReactions(
      String postId, String commentId, String commentRepliesId) async {
    replyReactionList.value.clear();
    replyLikeList.value.clear();
    replyLoveList.value.clear();
    replyHahaList.value.clear();
    replyWowList.value.clear();
    replySadList.value.clear();
    replyAngryList.value.clear();
    replyUnlikeList.value.clear();

    isReplyReactionLoading.value = true;

    debugPrint(
        '=============getCommentReplyReactions function call===============');

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'reaction-user-lists-comments-of-a-direct-post',
      requestData: {
        'postId': postId,
        'commentId': commentId,
        'commentRepliesId': commentRepliesId
      },
      responseDataKey: 'reactions',
    );

    debugPrint(
        '=============getCommentReplyReactions List on Going===============');

    if (response.isSuccessful) {
      debugPrint(
          '=============getCommentReplyReactions List ok===============');

      replyReactionList.value = (response.data as List)
          .map((element) => ReplyReactions.fromJson(element))
          .toList();
      calculateReplyReaction();
      debugPrint('ok');

      isReplyReactionLoading.value = false;

      debugPrint(
          '==========Reply reaction List================${replyReactionList.value}');

      //debugPrint('=============getCommentReactions List data${reactionList.value}===============');
    }
    // isReplyReactionLoading.value = false;
  }

  void calculateReplyReaction() {
    // replyLikeList.value.clear();
    // replyLoveList.value.clear();
    // replyHahaList.value.clear();
    // replyWowList.value.clear();
    // replySadList.value.clear();
    // replyAngryList.value.clear();
    // replyUnlikeList.value.clear();

    debugPrint(
        '============Reply Reaction List ${replyReactionList.value}=======================================================================');

    for (ReplyReactions reactionModel in replyReactionList.value) {
      switch (reactionModel.reactionType) {
        case 'like':
          replyLikeList.value.add(reactionModel);
          break;
        case 'love':
          replyLoveList.value.add(reactionModel);
          break;
        case 'haha':
          replyHahaList.value.add(reactionModel);
          break;
        case 'wow':
          replyWowList.value.add(reactionModel);
          break;
        case 'sad':
          replySadList.value.add(reactionModel);
          break;
        case 'angry':
          replyAngryList.value.add(reactionModel);
          break;
        case 'unlike':
          replyUnlikeList.value.add(reactionModel);
          break;
      }
    }

    //debugPrint('============Reply Reaction HaHa List ${replyHahaList.value[0].reactionType}=======================================================================');

    replyLikeList.refresh();
    replyLoveList.refresh();
    replyHahaList.refresh();
    replyWowList.refresh();
    replySadList.refresh();
    replyAngryList.refresh();
  }

  void calculateReaction() {
    for (CommentReactions reactionModel in reactionList.value) {
      switch (reactionModel.reactionType) {
        case 'like':
          likeList.value.add(reactionModel);
          break;
        case 'love':
          loveList.value.add(reactionModel);
          break;
        case 'haha':
          hahaList.value.add(reactionModel);
          break;
        case 'wow':
          wowList.value.add(reactionModel);
          break;
        case 'sad':
          sadList.value.add(reactionModel);
          break;
        case 'angry':
          angryList.value.add(reactionModel);
          break;
        case 'unlike':
          unlikeList.value.add(reactionModel);
          break;
      }
    }
    likeList.refresh();
    loveList.refresh();
    hahaList.refresh();
    wowList.refresh();
    sadList.refresh();
    angryList.refresh();
  }

  Future<void> pickFiles() async {
    debugPrint('=================X file Value start====================');

    final ImagePicker picker = ImagePicker();
    xfiles.value = await picker.pickMultipleMedia();

    debugPrint(
        '=================X file Value====================${xfiles.value}');
  }

  Future<void> onTapCreatePhotoComment(String userId, String postId) async {
    debugPrint('===================Photo comment Start=====================');

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-user-comment-by-post',
      isFormData: true,
      enableLoading: true,
      requestData: {
        'user_id': userId, //postModel.user_id?.id,
        'post_id': postId, //postModel.id,
        'comment_name': commentController.text,
        'image_or_video': null,
        'link': null,
        'link_title': null,
        'link_description': null,
        'link_image': null
      },
      mediaXFiles: xfiles.value,
    );

    debugPrint(
        '===================Photo comment Api Call end=====================');

    if (response.isSuccessful) {
      debugPrint(
          '===================Photo comment ${response.statusCode}=====================');

      // showSuccessSnackkbar(message: 'Post submitted successfully');
      // eventType = "work".obs;
      // eventSubType = "".obs;
      // orgName = "".obs;
      // designation = "".obs;
      // startDate = 'start date'.obs;
      // endDate = 'end date'.obs;
      // is_current_working = false.obs;
      //
      // ProfileController controller = Get.find();
      // controller.getPosts();
      // Get.toNamed(Routes.PROFILE);
    } else {
      debugPrint('');
    }
  }

  /////////////////////////////////////////////////////////////////////

  Future<void> shareUserPost(String sharePostId) async {
    debugPrint('Update model status code.............' 'funciton call');

    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'save-share-post-with-caption',
        requestData: {
          'share_post_id': sharePostId,
          'description': descriptionController.text.toString(),
          'privacy': postPrivacy.value,
        });

    debugPrint(
        'Update model status code.............${apiResponse.statusCode}');

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: 'Your post has been shared' ?? 'Error');
      ProfileController profileController = Get.find();
      pageNo = 1;

      getPosts();
      //Get.toNamed(Routes.PROFILE);
      // profileController.pageNo = 1;
      // await profileController.getPosts();
    } else {}
  }

  Future<void> getMergeStory(String storyId) async {
    ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'get-merge-story',
      requestData: {
        'story_id': storyId,
        'user_id': '${userModel.id}',
      },
    );
    if (response.isSuccessful) {
      debugPrint('');
    }
  }

  Future<StoryMergeModel?> getSingleStory(String storyId) async {
    ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'single-story',
      requestData: {
        'story_id': storyId,
        // 'user_id': '${userModel.id}',
      },
      responseDataKey: 'results',
    );
    if (response.isSuccessful) {
      StoryMergeModel storyMergeModel =
          StoryMergeModel.fromMap((response.data as List)[0]);
      debugPrint('');
      return storyMergeModel;
    } else {
      return null;
    }
  }

  Future<void> getAllStory() async {
    ApiResponse response = await _apiCommunication.doGetRequest(
      apiEndPoint: 'get-all-story',
    );
    if (response.isSuccessful) {
      debugPrint('');
    }
  }

  @override
  void onInit() async {
    _apiCommunication = ApiCommunication();
    postScrollController = ScrollController();
    loginCredential = LoginCredential();
    userModel = loginCredential.getUserData();
    commentController = TextEditingController();
    commentReplyController = TextEditingController();
    descriptionController = TextEditingController();

    await getPosts();
    await getAllStory();
    await getStories();
    super.onInit();
  }

  @override
  void onReady() {
    postScrollController.addListener(_scrollListener);
    super.onReady();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    super.onClose();
  }
}
