// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PrivacyModel {
  String? gender;
  String? about;
  String? nickname;
  PrivacyModel({
    this.gender,
    this.about,
    this.nickname,
  });

  PrivacyModel copyWith({
    String? gender,
    String? about,
    String? nickname,
  }) {
    return PrivacyModel(
      gender: gender ?? this.gender,
      about: about ?? this.about,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'about': about,
      'nickname': nickname,
    };
  }

  factory PrivacyModel.fromMap(Map<String, dynamic> map) {
    return PrivacyModel(
      gender: map['gender'] != null ? map['gender'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrivacyModel.fromJson(String source) =>
      PrivacyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PrivacyModel(gender: $gender, about: $about, nickname: $nickname)';

  @override
  bool operator ==(covariant PrivacyModel other) {
    if (identical(this, other)) return true;

    return other.gender == gender &&
        other.about == about &&
        other.nickname == nickname;
  }

  @override
  int get hashCode => gender.hashCode ^ about.hashCode ^ nickname.hashCode;
}
