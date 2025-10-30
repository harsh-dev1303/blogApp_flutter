import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({
    required File image,
    required BlogModel blog
    });

  Future<List<BlogModel>> fetchAllBlogs();
} 


class BlogRemoteDataSourceImp implements BlogRemoteDataSource{
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try{
      final uploadedBlog = await supabaseClient.from('blog').insert(blog.toJson()).select();  //this will return List<Map<String,dynamic>> but It returns only the rows that were just inserted — as long as you include .select() right after .insert().
      return BlogModel.fromMap(uploadedBlog.first);  //"uploadedBlog.first" will give map of one blog from DB
    }catch(e){
      throw ServerException(e.toString());
    }
    
    
  }
  
  @override
  Future<String> uploadImage({required File image, required BlogModel blog}) async {
    try{
       await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);

    }catch(e){
       throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> fetchAllBlogs() async {
    try{
      final blogList = await supabaseClient.from('blog').select('*,profiles(name)');

     return blogList.map((blog){
       return BlogModel.fromMap(blog);
      }).toList();

    }catch(e){
      throw ServerException(e.toString());
    }
    
  }
  
 
  
}