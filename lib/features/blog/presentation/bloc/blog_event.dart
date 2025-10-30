// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blog_bloc.dart';

sealed class BlogEvent {}

class BlogUploadEvent extends BlogEvent {
  final File image;
  final List<String> topics;
  final String title;
  final String content;
  final String posterId;
  
  BlogUploadEvent({
    required this.image,
    required this.topics,
    required this.title,
    required this.content,
    required this.posterId,
  });

}

class BlogFetchEvent extends BlogEvent{
  
}
