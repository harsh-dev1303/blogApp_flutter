import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<Blog, UploadBlogUsecaseParams> {
  final BlogRepository blogRepository;
  UploadBlogUsecase(this.blogRepository);
  
  @override
  Future<Either<Failure, Blog>> call(UploadBlogUsecaseParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogUsecaseParams {
  final File image;
  final List<String> topics;
  final String title;
  final String content;
  final String posterId;

  UploadBlogUsecaseParams({
    required this.image,
    required this.topics,
    required this.title,
    required this.content,
    required this.posterId,
  });
}
