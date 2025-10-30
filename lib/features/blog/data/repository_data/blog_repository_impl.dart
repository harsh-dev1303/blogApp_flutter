import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.connectionChecker,
    required this.blogLocalDataSource,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet connection"));
      }

      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        poster_id: posterId,
        title: title,
        content: content,
        image_url: '',
        topics: topics,
        updated_at: DateTime.now(),
      );

      final image_url = await blogRemoteDataSource.uploadImage(
        image: image,
        blog: blogModel,
      );

      final updatedBlogModel = blogModel.copyWith(image_url: image_url);

      final blog = await blogRemoteDataSource.uploadBlog(updatedBlogModel);

      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final localBlogs=blogLocalDataSource.getBlogsFromLocalDB();
        return Right(localBlogs);
      }

      final allBlogsList = await blogRemoteDataSource.fetchAllBlogs();
      blogLocalDataSource.uploadBlogToLocalDB(allBlogsList);
      return Right(allBlogsList);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
