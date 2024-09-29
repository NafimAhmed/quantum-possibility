// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quantum_possibilities_flutter/app/models/user_id.dart';

class FriendModel {
  String? id;
  String? createdAt;
  String? created_by;
  String? updatedAt;
  String? update_by;
  int? data_status;
  String? ip_address;
  String? relation_type;
  String? accept_reject_status;
  UserIdModel? connected_user_id;
  UserIdModel? user_id;
  int? v;
  FriendModel({
    this.id,
    this.createdAt,
    this.created_by,
    this.updatedAt,
    this.update_by,
    this.data_status,
    this.ip_address,
    this.relation_type,
    this.accept_reject_status,
    this.connected_user_id,
    this.user_id,
    this.v,
  });

  FriendModel copyWith({
    String? id,
    String? createdAt,
    String? created_by,
    String? updatedAt,
    String? update_by,
    int? data_status,
    String? ip_address,
    String? relation_type,
    String? accept_reject_status,
    UserIdModel? connected_user_id,
    UserIdModel? user_id,
    int? v,
  }) {
    return FriendModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      created_by: created_by ?? this.created_by,
      updatedAt: updatedAt ?? this.updatedAt,
      update_by: update_by ?? this.update_by,
      data_status: data_status ?? this.data_status,
      ip_address: ip_address ?? this.ip_address,
      relation_type: relation_type ?? this.relation_type,
      accept_reject_status: accept_reject_status ?? this.accept_reject_status,
      connected_user_id: connected_user_id ?? this.connected_user_id,
      user_id: user_id ?? this.user_id,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'created_by': created_by,
      'updatedAt': updatedAt,
      'update_by': update_by,
      'data_status': data_status,
      'ip_address': ip_address,
      'relation_type': relation_type,
      'accept_reject_status': accept_reject_status,
      'connected_user_id': connected_user_id?.toMap(),
      'user_id': user_id?.toMap(),
      'v': v,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      created_by:
          map['created_by'] != null ? map['created_by'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      update_by: map['update_by'] != null ? map['update_by'] as String : null,
      data_status:
          map['data_status'] != null ? map['data_status'] as int : null,
      ip_address:
          map['ip_address'] != null ? map['ip_address'] as String : null,
      relation_type:
          map['relation_type'] != null ? map['relation_type'] as String : null,
      accept_reject_status: map['accept_reject_status'] != null
          ? map['accept_reject_status'] as String
          : null,
      connected_user_id: map['connected_user_id'] != null
          ? UserIdModel.fromMap(
              map['connected_user_id'] as Map<String, dynamic>)
          : null,
      user_id: map['user_id'] != null
          ? UserIdModel.fromMap(map['user_id'] as Map<String, dynamic>)
          : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendModel.fromJson(String source) =>
      FriendModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FriendModel(id: $id, createdAt: $createdAt, created_by: $created_by, updatedAt: $updatedAt, update_by: $update_by, data_status: $data_status, ip_address: $ip_address, relation_type: $relation_type, accept_reject_status: $accept_reject_status, connected_user_id: $connected_user_id, user_id: $user_id, v: $v)';
  }

  @override
  bool operator ==(covariant FriendModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.created_by == created_by &&
        other.updatedAt == updatedAt &&
        other.update_by == update_by &&
        other.data_status == data_status &&
        other.ip_address == ip_address &&
        other.relation_type == relation_type &&
        other.accept_reject_status == accept_reject_status &&
        other.connected_user_id == connected_user_id &&
        other.user_id == user_id &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        created_by.hashCode ^
        updatedAt.hashCode ^
        update_by.hashCode ^
        data_status.hashCode ^
        ip_address.hashCode ^
        relation_type.hashCode ^
        accept_reject_status.hashCode ^
        connected_user_id.hashCode ^
        user_id.hashCode ^
        v.hashCode;
  }
}
