import 'dart:convert';

ReelsCommentModel reelsCommentModelFromJson(String str) =>
    ReelsCommentModel.fromJson(json.decode(str));

String reelsCommentModelToJson(ReelsCommentModel data) =>
    json.encode(data.toJson());

class ReelsCommentModel {
  int? status;
  List<Comment>? comments;

  ReelsCommentModel({
    this.status,
    this.comments,
  });

  factory ReelsCommentModel.fromJson(Map<String, dynamic> json) =>
      ReelsCommentModel(
        status: json['status'],
        comments: List<Comment>.from(
            json['comments'].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'comments': List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  String id;
  String commentName;
  String postId;
  dynamic postSingleItemId;
  UserId userId;
  String commentType;
  // bool commentEdited;
  // dynamic imageOrVideo;
  dynamic status;
  // dynamic ipAddress;
  String createdAt;
  String updatedAt;
  // int v;
  List<dynamic> commentReactions;
  List<Reply> replies;

  Comment({
    required this.id,
    required this.commentName,
    required this.postId,
    required this.postSingleItemId,
    required this.userId,
    required this.commentType,
    // required this.commentEdited,
    // required this.imageOrVideo,
    required this.status,
    // required this.ipAddress,
    required this.createdAt,
    required this.updatedAt,
    // required this.v,
    required this.commentReactions,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['_id'],
        commentName: json['comment_name'],
        postId: json['post_id']!,
        postSingleItemId: json['post_single_item_id'],
        userId: UserId.fromJson(json['user_id']),
        commentType: json['comment_type']!,
        // commentEdited: json["comment_edited"],
        // imageOrVideo: json["image_or_video"],
        status: json['status'],
        // ipAddress: json["ip_address"],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        // v: json["__v"],
        commentReactions:
            List<dynamic>.from(json['comment_reactions'].map((x) => x)),
        replies:
            List<Reply>.from(json['replies'].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'comment_name': commentName,
        'post_id': postId,
        'post_single_item_id': postSingleItemId,
        'user_id': userId.toJson(),
        'comment_type': commentType,
        // "comment_edited": commentEdited,
        // "image_or_video": imageOrVideo,
        'status': status,
        // "ip_address": ipAddress,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        // "__v": v,
        'comment_reactions': List<dynamic>.from(commentReactions.map((x) => x)),
        'replies': List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class Reply {
  String id;
  String postId;
  String commentId;
  UserId repliesUserId;
  String repliesCommentName;
  // String commentType;
  // bool commentEdited;
  // dynamic imageOrVideo;
  dynamic status;
  // dynamic ipAddress;
  // dynamic createdBy;
  // dynamic updatedBy;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int v;
  // List<dynamic> repliesCommentReactions;

  Reply({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.repliesUserId,
    required this.repliesCommentName,
    // required this.commentType,
    // required this.commentEdited,
    // required this.imageOrVideo,
    // required this.status,
    // required this.ipAddress,
    // required this.createdBy,
    // required this.updatedBy,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.v,
    // required this.repliesCommentReactions,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json['_id'],
        postId: json['post_id']!,
        commentId: json['comment_id'],
        repliesUserId: UserId.fromJson(json['replies_user_id']),
        repliesCommentName: json['replies_comment_name'],
        // commentType: json["comment_type"],
        // commentEdited: json["comment_edited"],
        // imageOrVideo: json["image_or_video"],
        // status: json["status"],
        // ipAddress: json["ip_address"],
        // createdBy: json["created_by"],
        // updatedBy: json["updated_by"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
        // repliesCommentReactions: List<dynamic>.from(json["replies_comment_reactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'post_id': postId,
        'comment_id': commentId,
        'replies_user_id': repliesUserId.toJson(),
        'replies_comment_name': repliesCommentName,
        // "comment_type": commentType,
        // "comment_edited": commentEdited,
        // "image_or_video": imageOrVideo,
        // "status": status,
        // "ip_address": ipAddress,
        // "created_by": createdBy,
        // "updated_by": updatedBy,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
        // "replies_comment_reactions": List<dynamic>.from(repliesCommentReactions.map((x) => x)),
      };
}

class UserId {
  String id;
  String firstName;
  String lastName;
  String username;
  String email;
  // List<dynamic> emailList;
  // String phone;
  // List<PhoneList> phoneList;
  // String password;
  String profilePic;
  // String coverPic;
  // dynamic userStatus;
  // Gender gender;
  // Religion? religion;
  // DateTime dateOfBirth;
  // User? userBio;
  // List<dynamic>? language;
  // dynamic passport;
  // LastLogin? lastLogin;
  // dynamic user2FaStatus;
  // dynamic secondaryEmail;
  // dynamic recoveryEmail;
  // dynamic relationStatus;
  // HomeTown? homeTown;
  // BirthPlace? birthPlace;
  // dynamic bloodGroup;
  // ResetPasswordToken? resetPasswordToken;
  // dynamic websites;
  // UserNickname? userNickname;
  // User? userAbout;
  // dynamic presentTown;
  // String? resetPasswordTokenExpires;
  // dynamic userRole;
  // String? lockProfile;
  // dynamic status;
  // dynamic ipAddress;
  // dynamic createdBy;
  // dynamic updateBy;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int v;

  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    // required this.emailList,
    // required this.phone,
    // required this.phoneList,
    // required this.password,
    required this.profilePic,
    // required this.coverPic,
    // required this.userStatus,
    // required this.gender,
    // required this.religion,
    // required this.dateOfBirth,
    // required this.userBio,
    // required this.language,
    // required this.passport,
    // required this.lastLogin,
    // required this.user2FaStatus,
    // required this.secondaryEmail,
    // required this.recoveryEmail,
    // required this.relationStatus,
    // required this.homeTown,
    // required this.birthPlace,
    // required this.bloodGroup,
    // required this.resetPasswordToken,
    // this.websites,
    // required this.userNickname,
    // required this.userAbout,
    // this.presentTown,
    // required this.resetPasswordTokenExpires,
    // required this.userRole,
    // required this.lockProfile,
    // required this.status,
    // required this.ipAddress,
    // required this.createdBy,
    // required this.updateBy,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json['_id']!,
        firstName: json['first_name']!,
        lastName: json['last_name']!,
        username: json['username']!,
        email: json['email']!,
        // emailList: List<dynamic>.from(json["email_list"].map((x) => x)),
        // phone: json["phone"],
        // phoneList: List<PhoneList>.from(json["phone_list"].map((x) => phoneListValues.map[x]!)),
        // password: json["password"]!,
        profilePic: json['profile_pic']!,
        // coverPic: json["cover_pic"]!,
        // userStatus: json["user_status"],
        // gender: genderValues.map[json["gender"]]!,
        // religion: religionValues.map[json["religion"]]!,
        // dateOfBirth: DateTime.parse(json["date_of_birth"]),
        // userBio: userValues.map[json["user_bio"]]!,
        // language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
        // passport: json["passport"],
        // lastLogin: lastLoginValues.map[json["last_login"]]!,
        // user2FaStatus: json["user_2fa_status"],
        // secondaryEmail: json["secondary_email"],
        // recoveryEmail: json["recovery_email"],
        // relationStatus: json["relation_status"],
        // homeTown: homeTownValues.map[json["home_town"]]!,
        // birthPlace: birthPlaceValues.map[json["birth_place"]]!,
        // bloodGroup: json["blood_group"],
        // resetPasswordToken: resetPasswordTokenValues.map[json["reset_password_token"]]!,
        // websites: json["websites"],
        // userNickname: userNicknameValues.map[json["user_nickname"]]!,
        // userAbout: userValues.map[json["user_about"]]!,
        // presentTown: json["present_town"],
        // resetPasswordTokenExpires: json["reset_password_token_expires"],
        // userRole: json["user_role"],
        // lockProfile: json["lock_profile"],
        // status: json["status"],
        // ipAddress: json["ip_address"],
        // createdBy: json["created_by"],
        // updateBy: json["update_by"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        // "email_list": List<dynamic>.from(emailList.map((x) => x)),
        // "phone": phone,
        // "phone_list": List<dynamic>.from(phoneList.map((x) => phoneListValues.reverse[x])),
        // "password": passwordValues.reverse[password],
        'profile_pic': profilePic,
        // "cover_pic": coverPicValues.reverse[coverPic],
        // "user_status": userStatus,
        // "gender": genderValues.reverse[gender],
        // "religion": religionValues.reverse[religion],
        // "date_of_birth": dateOfBirth.toIso8601String(),
        // "user_bio": userValues.reverse[userBio],
        // "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        // "passport": passport,
        // "last_login": lastLoginValues.reverse[lastLogin],
        // "user_2fa_status": user2FaStatus,
        // "secondary_email": secondaryEmail,
        // "recovery_email": recoveryEmail,
        // "relation_status": relationStatus,
        // "home_town": homeTownValues.reverse[homeTown],
        // "birth_place": birthPlaceValues.reverse[birthPlace],
        // "blood_group": bloodGroup,
        // "reset_password_token": resetPasswordTokenValues.reverse[resetPasswordToken],
        // "websites": websites,
        // "user_nickname": userNicknameValues.reverse[userNickname],
        // "user_about": userValues.reverse[userAbout],
        // "present_town": presentTown,
        // "reset_password_token_expires": resetPasswordTokenExpires,
        // "user_role": userRole,
        // "lock_profile": lockProfile,
        // "status": status,
        // "ip_address": ipAddress,
        // "created_by": createdBy,
        // "update_by": updateBy,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };
}

























// import 'dart:convert';
//
// ReelsCommentModel reelsCommentModelFromJson(String str) => ReelsCommentModel.fromJson(json.decode(str));
//
// String reelsCommentModelToJson(ReelsCommentModel data) => json.encode(data.toJson());
//
// class ReelsCommentModel {
//   int? status;
//   List<Comment>? comments;
//
//   ReelsCommentModel({
//      this.status,
//      this.comments,
//   });
//
//   factory ReelsCommentModel.fromJson(Map<String, dynamic> json) => ReelsCommentModel(
//     status: json["status"],
//     comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
//   };
// }
//
// class Comment {
//   String id;
//   String commentName;
//   String postId;
//   dynamic postSingleItemId;
//   UserId? userId;
//   String commentType;
//   bool commentEdited;
//   dynamic imageOrVideo;
//   dynamic status;
//   dynamic ipAddress;
//   dynamic createdBy;
//   dynamic updatedBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//
//   Comment({
//     required this.id,
//     required this.commentName,
//     required this.postId,
//     required this.postSingleItemId,
//      this.userId,
//     required this.commentType,
//     required this.commentEdited,
//     required this.imageOrVideo,
//     required this.status,
//     required this.ipAddress,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });
//
//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//     id: json["_id"],
//     commentName: json["comment_name"],
//     postId: json["post_id"],
//     postSingleItemId: json["post_single_item_id"],
//     userId: UserId.fromJson(json["user_id"]),
//     commentType: json["comment_type"],
//     commentEdited: json["comment_edited"],
//     imageOrVideo: json["image_or_video"],
//     status: json["status"],
//     ipAddress: json["ip_address"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "comment_name": commentName,
//     "post_id": postId,
//     "post_single_item_id": postSingleItemId,
//     "user_id": userId?.toJson(),
//     "comment_type": commentType,
//     "comment_edited": commentEdited,
//     "image_or_video": imageOrVideo,
//     "status": status,
//     "ip_address": ipAddress,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class UserId {
//   dynamic websites;
//   dynamic presentTown;
//   String id;
//   String firstName;
//   String lastName;
//   String username;
//   String email;
//   String phone;
//   String password;
//   String profilePic;
//   String coverPic;
//   dynamic userStatus;
//   String gender;
//   String religion;
//   DateTime dateOfBirth;
//   String userBio;
//   dynamic language;
//   dynamic passport;
//   String lastLogin;
//   dynamic user2FaStatus;
//   dynamic secondaryEmail;
//   dynamic recoveryEmail;
//   dynamic relationStatus;
//   String homeTown;
//   String birthPlace;
//   dynamic bloodGroup;
//   String resetPasswordToken;
//   String resetPasswordTokenExpires;
//   dynamic userRole;
//   dynamic status;
//   dynamic ipAddress;
//   dynamic createdBy;
//   dynamic updateBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//   String lockProfile;
//   List<dynamic> emailList;
//   List<String> phoneList;
//   String userAbout;
//   String userNickname;
//
//   UserId({
//     required this.websites,
//     required this.presentTown,
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.username,
//     required this.email,
//     required this.phone,
//     required this.password,
//     required this.profilePic,
//     required this.coverPic,
//     required this.userStatus,
//     required this.gender,
//     required this.religion,
//     required this.dateOfBirth,
//     required this.userBio,
//     required this.language,
//     required this.passport,
//     required this.lastLogin,
//     required this.user2FaStatus,
//     required this.secondaryEmail,
//     required this.recoveryEmail,
//     required this.relationStatus,
//     required this.homeTown,
//     required this.birthPlace,
//     required this.bloodGroup,
//     required this.resetPasswordToken,
//     required this.resetPasswordTokenExpires,
//     required this.userRole,
//     required this.status,
//     required this.ipAddress,
//     required this.createdBy,
//     required this.updateBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.lockProfile,
//     required this.emailList,
//     required this.phoneList,
//     required this.userAbout,
//     required this.userNickname,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     websites: json["websites"],
//     presentTown: json["present_town"],
//     id: json["_id"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     username: json["username"],
//     email: json["email"],
//     phone: json["phone"],
//     password: json["password"],
//     profilePic: json["profile_pic"],
//     coverPic: json["cover_pic"],
//     userStatus: json["user_status"],
//     gender: json["gender"],
//     religion: json["religion"],
//     dateOfBirth: DateTime.parse(json["date_of_birth"]),
//     userBio: json["user_bio"],
//     language: json["language"],
//     passport: json["passport"],
//     lastLogin: json["last_login"],
//     user2FaStatus: json["user_2fa_status"],
//     secondaryEmail: json["secondary_email"],
//     recoveryEmail: json["recovery_email"],
//     relationStatus: json["relation_status"],
//     homeTown: json["home_town"],
//     birthPlace: json["birth_place"],
//     bloodGroup: json["blood_group"],
//     resetPasswordToken: json["reset_password_token"],
//     resetPasswordTokenExpires: json["reset_password_token_expires"],
//     userRole: json["user_role"],
//     status: json["status"],
//     ipAddress: json["ip_address"],
//     createdBy: json["created_by"],
//     updateBy: json["update_by"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//     lockProfile: json["lock_profile"],
//     emailList: List<dynamic>.from(json["email_list"].map((x) => x)),
//     phoneList: List<String>.from(json["phone_list"].map((x) => x)),
//     userAbout: json["user_about"],
//     userNickname: json["user_nickname"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "websites": websites,
//     "present_town": presentTown,
//     "_id": id,
//     "first_name": firstName,
//     "last_name": lastName,
//     "username": username,
//     "email": email,
//     "phone": phone,
//     "password": password,
//     "profile_pic": profilePic,
//     "cover_pic": coverPic,
//     "user_status": userStatus,
//     "gender": gender,
//     "religion": religion,
//     "date_of_birth": dateOfBirth.toIso8601String(),
//     "user_bio": userBio,
//     "language": language,
//     "passport": passport,
//     "last_login": lastLogin,
//     "user_2fa_status": user2FaStatus,
//     "secondary_email": secondaryEmail,
//     "recovery_email": recoveryEmail,
//     "relation_status": relationStatus,
//     "home_town": homeTown,
//     "birth_place": birthPlace,
//     "blood_group": bloodGroup,
//     "reset_password_token": resetPasswordToken,
//     "reset_password_token_expires": resetPasswordTokenExpires,
//     "user_role": userRole,
//     "status": status,
//     "ip_address": ipAddress,
//     "created_by": createdBy,
//     "update_by": updateBy,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "__v": v,
//     "lock_profile": lockProfile,
//     "email_list": List<dynamic>.from(emailList.map((x) => x)),
//     "phone_list": List<dynamic>.from(phoneList.map((x) => x)),
//     "user_about": userAbout,
//     "user_nickname": userNickname,
//   };
// }
