import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.poster_id,
    required super.title,
    required super.content,
    required super.image_url,
    required super.topics,
    required super.updated_at,
    super.poster_name
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': poster_id,
      'title': title,
      'content': content,
      'image_url': image_url,
      'topics': topics,
      'updated_at': updated_at.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      poster_id: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image_url: map['image_url'] as String,
      topics: map['topics'] != null
        ? List<String>.from(map['topics'] as List)
        : [],
      updated_at: DateTime.parse(map['updated_at']),
      poster_name: map['profiles'] != null ? map['profiles']['name'] : null
      );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? image_url,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      poster_id: posterId ?? this.poster_id,
      title: title ?? this.title,
      content: content ?? this.content,
      image_url: image_url ?? this.image_url,
      topics: topics ?? this.topics,
      updated_at: updatedAt ?? this.updated_at,
    );
  }
}
