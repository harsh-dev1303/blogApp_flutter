import 'dart:io';

import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_all_blog_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final FetchAllBlogUsecase _fetchAllBlogUsecase;

  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase ,
    required FetchAllBlogUsecase fetchAllBlogUsecase,
     })
    : _uploadBlogUsecase = uploadBlogUsecase,
      _fetchAllBlogUsecase = fetchAllBlogUsecase,

      super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoadingState()));
    on<BlogUploadEvent>(_blogUploadEvent);
    on<BlogFetchEvent>(_blogFetchEvent);
    
  }

  void _blogUploadEvent(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase.call(
      UploadBlogUsecaseParams(
        image: event.image,
        topics: event.topics,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
      ),
    );

    res.fold(
      (failure)=>emit(BlogErrorState(failure.message)), 
      (blog)=>emit(BlogSuccessState(blog))
      );
  }

  void _blogFetchEvent(BlogFetchEvent event, Emitter<BlogState> emit)async {
    final res =await  _fetchAllBlogUsecase.call(NoParams());
    res.fold(
      (failure)=>emit(BlogErrorState(failure.message)), 
      (blogList){
        print("blog List: ${blogList.length}");
        emit(BlogFetchedSuccessState(blogList));
        }
      );
    
  }
}
