import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route()=>MaterialPageRoute(builder:(context)=>AddNewBlogPage() );
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Blog App")),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, BlogPage.route());
            }, 
            icon:Icon(Icons.add)
          )
        ],
      ),
    );
  }
}


