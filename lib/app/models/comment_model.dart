import 'user_id.dart';

class CommentModel {
  String? id;
  String? comment_name;
  String? post_id;
  String? post_single_item_id;
  UserIdModel? user_id;
  String? comment_type;
  bool? comment_edited;
  String? image_or_video;
  String? link;
  String? link_title;
  String? link_description;
  String? link_image;
  String? status;
  String? ip_address;
  String? created_by;
  String? updated_by;
  String? createdAt;
  String? updatedAt;
  List<CommentReaction>? comment_reactions;
  List<CommentReplay>? replies;
  int? v;
  CommentModel({
    this.id,
    this.comment_name,
    this.post_id,
    this.post_single_item_id,
    this.user_id,
    this.comment_type,
    this.comment_edited,
    this.image_or_video,
    this.link,
    this.link_title,
    this.link_description,
    this.link_image,
    this.status,
    this.ip_address,
    this.created_by,
    this.updated_by,
    this.createdAt,
    this.updatedAt,
    this.comment_reactions,
    this.replies,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'comment_name': comment_name,
      'post_id': post_id,
      'post_single_item_id': post_single_item_id,
      'user_id': user_id?.toMap(),
      'comment_type': comment_type,
      'comment_edited': comment_edited,
      'image_or_video': image_or_video,
      'link': link,
      'link_title': link_title,
      'link_description': link_description,
      'link_image': link_image,
      'status': status,
      'ip_address': ip_address,
      'created_by': created_by,
      'updated_by': updated_by,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'comment_reactions': comment_reactions,
      'replies': replies,
      '__v': v,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      comment_name:
          map['comment_name'] != null ? map['comment_name'] as String : null,
      post_id: map['post_id'] != null ? map['post_id'] as String : null,
      post_single_item_id: map['post_single_item_id'] != null
          ? map['post_single_item_id'] as String
          : null,
      user_id: map['user_id'] != null
          ? UserIdModel.fromMap(map['user_id'] as Map<String, dynamic>)
          : null,
      comment_type:
          map['comment_type'] != null ? map['comment_type'] as String : null,
      comment_edited:
          map['comment_edited'] != null ? map['comment_edited'] as bool : null,
      image_or_video: map['image_or_video'] != null
          ? map['image_or_video'] as String
          : null,
      link: map['link'] != null ? map['link'] as String : null,
      link_title:
          map['link_title'] != null ? map['link_title'] as String : null,
      link_description: map['link_description'] != null
          ? map['link_description'] as String
          : null,
      link_image:
          map['link_image'] != null ? map['link_image'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      ip_address:
          map['ip_address'] != null ? map['ip_address'] as String : null,
      created_by:
          map['created_by'] != null ? map['created_by'] as String : null,
      updated_by:
          map['updated_by'] != null ? map['updated_by'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      comment_reactions: map['comment_reactions'] != null
          ? (map['comment_reactions'] as List)
              .map((e) => CommentReaction.fromMap(e))
              .toList()
          : null,
      replies: map['replies'] != null
          ? (map['replies'] as List)
              .map((e) => CommentReplay.fromMap(e))
              .toList()
          : null,
      v: map['__v'] != null ? map['__v'] as int : null,
    );
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, comment_name: $comment_name, post_id: $post_id, post_single_item_id: $post_single_item_id, user_id: $user_id, comment_type: $comment_type, comment_edited: $comment_edited, image_or_video: $image_or_video, link: $link, link_title: $link_title, link_description: $link_description, link_image: $link_image, status: $status, ip_address: $ip_address, created_by: $created_by, updated_by: $updated_by, createdAt: $createdAt, updatedAt: $updatedAt, comment_reactions: $comment_reactions, replies: $replies, v: $v)';
  }
}

class CommentReaction {
  String? id;
  String? post_id;
  String? post_single_item_id;
  String? user_id;
  String? comment_id;
  String? comment_replies_id;
  String? reaction_type;
  int? v;
  CommentReaction({
    this.id,
    this.post_id,
    this.post_single_item_id,
    this.user_id,
    this.comment_id,
    this.comment_replies_id,
    this.reaction_type,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post_id': post_id,
      'post_single_item_id': post_single_item_id,
      'user_id': user_id,
      'comment_id': comment_id,
      'comment_replies_id': comment_replies_id,
      'reaction_type': reaction_type,
      'v': v,
    };
  }

  factory CommentReaction.fromMap(Map<String, dynamic> map) {
    return CommentReaction(
      id: map['id'] != null ? map['id'] as String : null,
      post_id: map['post_id'] != null ? map['post_id'] as String : null,
      post_single_item_id: map['post_single_item_id'] != null
          ? map['post_single_item_id'] as String
          : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      comment_id:
          map['comment_id'] != null ? map['comment_id'] as String : null,
      comment_replies_id: map['comment_replies_id'] != null
          ? map['comment_replies_id'] as String
          : null,
      reaction_type:
          map['reaction_type'] != null ? map['reaction_type'] as String : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  @override
  String toString() {
    return 'CommentReaction(id: $id, post_id: $post_id, post_single_item_id: $post_single_item_id, user_id: $user_id, comment_id: $comment_id, comment_replies_id: $comment_replies_id, reaction_type: $reaction_type, v: $v)';
  }
}

class CommentReplay {
  String? id;
  String? comment_id;
  UserIdModel? replies_user_id;
  String? post_id;
  String? replies_comment_name;
  String? comment_type;
  bool? comment_edited;
  String? image_or_video;
  String? link;
  String? link_title;
  String? link_description;
  String? link_image;
  String? status;
  String? ip_address;
  String? created_by;
  String? updated_by;
  String? createdAt;
  String? updatedAt;
  List<RepliesCommentReaction>? replies_comment_reactions;
  int? v;
  CommentReplay({
     this.id,
    this.comment_id,
    this.replies_user_id,
    this.post_id,
    this.replies_comment_name,
    this.comment_type,
    this.comment_edited,
    this.image_or_video,
    this.link,
    this.link_title,
    this.link_description,
    this.link_image,
    this.status,
    this.ip_address,
    this.created_by,
    this.updated_by,
    this.createdAt,
    this.updatedAt,
    this.replies_comment_reactions,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment_id': comment_id,
      'replies_user_id': replies_user_id?.toMap(),
      'post_id': post_id,
      'replies_comment_name': replies_comment_name,
      'comment_type': comment_type,
      'comment_edited': comment_edited,
      'image_or_video': image_or_video,
      'link': link,
      'link_title': link_title,
      'link_description': link_description,
      'link_image': link_image,
      'status': status,
      'ip_address': ip_address,
      'created_by': created_by,
      'updated_by': updated_by,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'replies_comment_reactions': replies_comment_reactions,
      'v': v,
    };
  }

  factory CommentReplay.fromMap(Map<String, dynamic> map) {
    return CommentReplay(
      id:  map['_id'] != null ? map['_id'] as String : null,
      comment_id:
          map['comment_id'] != null ? map['comment_id'] as String : null,
      replies_user_id: map['replies_user_id'] != null
          ? UserIdModel.fromMap(map['replies_user_id'] as Map<String, dynamic>)
          : null,
      post_id: map['post_id'] != null ? map['post_id'] as String : null,
      replies_comment_name: map['replies_comment_name'] != null
          ? map['replies_comment_name'] as String
          : null,
      comment_type:
          map['comment_type'] != null ? map['comment_type'] as String : null,
      comment_edited:
          map['comment_edited'] != null ? map['comment_edited'] as bool : null,
      image_or_video: map['image_or_video'] != null
          ? map['image_or_video'] as String
          : null,
      link: map['link'] != null ? map['link'] as String : null,
      link_title:
          map['link_title'] != null ? map['link_title'] as String : null,
      link_description: map['link_description'] != null
          ? map['link_description'] as String
          : null,
      link_image:
          map['link_image'] != null ? map['link_image'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      ip_address:
          map['ip_address'] != null ? map['ip_address'] as String : null,
      created_by:
          map['created_by'] != null ? map['created_by'] as String : null,
      updated_by:
          map['updated_by'] != null ? map['updated_by'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      replies_comment_reactions: map['replies_comment_reactions'] != null
          ? (map['replies_comment_reactions'] as List)
              .map((e) => RepliesCommentReaction.fromMap(e))
              .toList()
          : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  @override
  String toString() {
    return 'CommentReplay(id: $id, comment_id: $comment_id, replies_user_id: $replies_user_id, post_id: $post_id, replies_comment_name: $replies_comment_name, comment_type: $comment_type, comment_edited: $comment_edited, image_or_video: $image_or_video, link: $link, link_title: $link_title, link_description: $link_description, link_image: $link_image, status: $status, ip_address: $ip_address, created_by: $created_by, updated_by: $updated_by, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}

class RepliesCommentReaction {
  String? id;
  String? post_id;
  String? post_single_item_id;
  String? user_id;
  String? comment_id;
  String? comment_replies_id;
  String? reaction_type;
  int? v;
  RepliesCommentReaction({
    this.id,
    this.post_id,
    this.post_single_item_id,
    this.user_id,
    this.comment_id,
    this.comment_replies_id,
    this.reaction_type,
    this.v,
  });

  factory RepliesCommentReaction.fromMap(Map<String, dynamic> map) {
    return RepliesCommentReaction(
      id: map['_id'] != null ? map['_id'] as String : null,
      post_id: map['post_id'] != null ? map['post_id'] as String : null,
      post_single_item_id: map['post_single_item_id'] != null
          ? map['post_single_item_id'] as String
          : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      comment_id:
          map['comment_id'] != null ? map['comment_id'] as String : null,
      comment_replies_id: map['comment_replies_id'] != null
          ? map['comment_replies_id'] as String
          : null,
      reaction_type:
          map['reaction_type'] != null ? map['reaction_type'] as String : null,
      v: map['__v'] != null ? map['__v'] as int : null,
    );
  }

  @override
  String toString() {
    return 'RepliesCommentReaction(id: $id, post_id: $post_id, post_single_item_id: $post_single_item_id, user_id: $user_id, comment_id: $comment_id, comment_replies_id: $comment_replies_id, reaction_type: $reaction_type, v: $v)';
  }
}
