part of 'blog_bloc.dart';


sealed class BlogState {}

final class BlogInitial extends BlogState {}
final class BlogLoadingState extends BlogState{}

final class BlogSuccessState extends BlogState{
  final Blog blog;
  BlogSuccessState(this.blog);
}
final class BlogErrorState extends BlogState{
  final String mssg;
  BlogErrorState(this.mssg);
}

final class BlogFetchedSuccessState extends BlogState{
  final List<Blog> blogList;
  BlogFetchedSuccessState(this.blogList);
}
