import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource{
  void uploadBlogToLocalDB(List<BlogModel> blogList);
  List<BlogModel> getBlogsFromLocalDB();
}


class BlogLocalDataSourceImpl implements BlogLocalDataSource{
  Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> getBlogsFromLocalDB() {
    List<BlogModel> blogList=[];
    //write will create transaction between local db which is good for upload and fecth data faster
    box.read((){
      for(int i=0; i<box.length; i++){
        blogList.add(BlogModel.fromMap(box.get(i.toString())));
      }
    });
    
    return blogList;
  }

  @override
  void uploadBlogToLocalDB(List<BlogModel> blogList) {
    box.clear();
    //write will create transaction between local db which is good for upload and fecth data faster
    box.write((){             
      for(int i=0; i<blogList.length; i++){
        box.put(i.toString(),blogList[i].toJson());
      }

    });
  }
  
}