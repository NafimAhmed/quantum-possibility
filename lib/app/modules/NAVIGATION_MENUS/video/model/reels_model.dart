// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReelsModel {
  String? id;
  String? description;
  String? user_id;
  String? video;
  String? reels_privacy;
  String? status;
  String? ipAddress;
  String? createdAt;
  String? updatedAt;
  ReelUserModel? reel_user;
  List<ReelsReactionModel>? reactions;
  int? comment_count;
  int? reaction_count;
  ReelsModel({
    this.id,
    this.description,
    this.user_id,
    this.video,
    this.reels_privacy,
    this.status,
    this.ipAddress,
    this.createdAt,
    this.updatedAt,
    this.reel_user,
    this.reactions,
    this.comment_count,
    this.reaction_count,
  });

  ReelsModel copyWith({
    String? id,
    String? description,
    String? user_id,
    String? video,
    String? reels_privacy,
    String? status,
    String? ipAddress,
    String? createdAt,
    String? updatedAt,
    ReelUserModel? reel_user,
    List<ReelsReactionModel>? reactions,
    int? comment_count,
    int? reaction_count,
  }) {
    return ReelsModel(
      id: id ?? this.id,
      description: description ?? this.description,
      user_id: user_id ?? this.user_id,
      video: video ?? this.video,
      reels_privacy: reels_privacy ?? this.reels_privacy,
      status: status ?? this.status,
      ipAddress: ipAddress ?? this.ipAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reel_user: reel_user ?? this.reel_user,
      reactions: reactions ?? this.reactions,
      comment_count: comment_count ?? this.comment_count,
      reaction_count: reaction_count ?? this.reaction_count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'description': description,
      'user_id': user_id,
      'video': video,
      'reels_privacy': reels_privacy,
      'status': status,
      'ipAddress': ipAddress,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'reel_user': reel_user?.toMap(),
      // 'reactions': reactions.map((x) => x?.toMap()).toList(),
      'comment_count': comment_count,
      'reaction_count': reaction_count,
    };
  }

  factory ReelsModel.fromMap(Map<String, dynamic> map) {
    return ReelsModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      reels_privacy:
          map['reels_privacy'] != null ? map['reels_privacy'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      ipAddress: map['ipAddress'] != null ? map['ipAddress'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      reel_user: map['reel_user'] != null
          ? ReelUserModel.fromMap(map['reel_user'] as Map<String, dynamic>)
          : null,
      reactions: map['reactions'] != null
          ? (map['reactions'] as List)
              .map((e) => ReelsReactionModel.fromMap(e))
              .toList()
          : null,
      comment_count:
          map['comment_count'] != null ? map['comment_count'] as int : null,
      reaction_count:
          map['reaction_count'] != null ? map['reaction_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelsModel.fromJson(String source) =>
      ReelsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReelsModel(id: $id, description: $description, user_id: $user_id, video: $video, reels_privacy: $reels_privacy, status: $status, ipAddress: $ipAddress, createdAt: $createdAt, updatedAt: $updatedAt, reel_user: $reel_user, reactions: $reactions, commentCount: $comment_count, reactionCount: $reaction_count)';
  }

  @override
  bool operator ==(covariant ReelsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.user_id == user_id &&
        other.video == video &&
        other.reels_privacy == reels_privacy &&
        other.status == status &&
        other.ipAddress == ipAddress &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.reel_user == reel_user &&
        listEquals(other.reactions, reactions) &&
        other.comment_count == comment_count &&
        other.reaction_count == reaction_count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        user_id.hashCode ^
        video.hashCode ^
        reels_privacy.hashCode ^
        status.hashCode ^
        ipAddress.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        reel_user.hashCode ^
        reactions.hashCode ^
        comment_count.hashCode ^
        reaction_count.hashCode;
  }
}

class ReelUserModel {
  String? id;
  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? phone;
  String? password;
  String? profile_pic;
  String? cover_pic;
  String? user_status;
  String? gender;
  String? religion;
  String? date_of_birth;
  String? user_bio;
  String? language;
  ReelUserModel({
    this.id,
    this.first_name,
    this.last_name,
    this.username,
    this.email,
    this.phone,
    this.password,
    this.profile_pic,
    this.cover_pic,
    this.user_status,
    this.gender,
    this.religion,
    this.date_of_birth,
    this.user_bio,
    this.language,
  });

  ReelUserModel copyWith({
    String? id,
    String? first_name,
    String? last_name,
    String? username,
    String? email,
    String? phone,
    String? password,
    String? profile_pic,
    String? cover_pic,
    String? user_status,
    String? gender,
    String? religion,
    String? date_of_birth,
    String? user_bio,
    String? language,
  }) {
    return ReelUserModel(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      profile_pic: profile_pic ?? this.profile_pic,
      cover_pic: cover_pic ?? this.cover_pic,
      user_status: user_status ?? this.user_status,
      gender: gender ?? this.gender,
      religion: religion ?? this.religion,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      user_bio: user_bio ?? this.user_bio,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'profile_pic': profile_pic,
      'cover_pic': cover_pic,
      'user_status': user_status,
      'gender': gender,
      'religion': religion,
      'date_of_birth': date_of_birth,
      'user_bio': user_bio,
      'language': language,
    };
  }

  factory ReelUserModel.fromMap(Map<String, dynamic> map) {
    return ReelUserModel(
      id: map['id'] != null ? map['id'] as String : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      profile_pic:
          map['profile_pic'] != null ? map['profile_pic'] as String : null,
      cover_pic: map['cover_pic'] != null ? map['cover_pic'] as String : null,
      user_status:
          map['user_status'] != null ? map['user_status'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      religion: map['religion'] != null ? map['religion'] as String : null,
      date_of_birth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      user_bio: map['user_bio'] != null ? map['user_bio'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelUserModel.fromJson(String source) =>
      ReelUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReelUserModel(id: $id, first_name: $first_name, last_name: $last_name, username: $username, email: $email, phone: $phone, password: $password, profile_pic: $profile_pic, cover_pic: $cover_pic, user_status: $user_status, gender: $gender, religion: $religion, date_of_birth: $date_of_birth, user_bio: $user_bio, language: $language)';
  }

  @override
  bool operator ==(covariant ReelUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.profile_pic == profile_pic &&
        other.cover_pic == cover_pic &&
        other.user_status == user_status &&
        other.gender == gender &&
        other.religion == religion &&
        other.date_of_birth == date_of_birth &&
        other.user_bio == user_bio &&
        other.language == language;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        profile_pic.hashCode ^
        cover_pic.hashCode ^
        user_status.hashCode ^
        gender.hashCode ^
        religion.hashCode ^
        date_of_birth.hashCode ^
        user_bio.hashCode ^
        language.hashCode;
  }
}

class ReelsReactionModel {
  String? user_id;
  String? reaction_type;
  ReelsReactionModel({
    this.user_id,
    this.reaction_type,
  });

  ReelsReactionModel copyWith({
    String? user_id,
    String? reaction_type,
  }) {
    return ReelsReactionModel(
      user_id: user_id ?? this.user_id,
      reaction_type: reaction_type ?? this.reaction_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'reaction_type': reaction_type,
    };
  }

  factory ReelsReactionModel.fromMap(Map<String, dynamic> map) {
    return ReelsReactionModel(
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      reaction_type:
          map['reaction_type'] != null ? map['reaction_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelsReactionModel.fromJson(String source) =>
      ReelsReactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReelsReactionModel(user_id: $user_id, reaction_type: $reaction_type)';

  @override
  bool operator ==(covariant ReelsReactionModel other) {
    if (identical(this, other)) return true;

    return other.user_id == user_id && other.reaction_type == reaction_type;
  }

  @override
  int get hashCode => user_id.hashCode ^ reaction_type.hashCode;
}
