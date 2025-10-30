import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  static route(Blog blog)=>MaterialPageRoute(builder: (context)=>BlogViewerPage(blog: blog) );
  const BlogViewerPage({
    super.key,
    required this.blog
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 20),
                Text("By ${blog.poster_name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
                ),
                SizedBox(height: 5,),
                Text('${FormatDateTimeBydMMMYYYY(blog.updated_at)} . ${CalculateReadingTime(blog.content)} min',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:AppPallete.greyColor,
                  fontSize: 16
                ),
                ),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.image_url,
                    height: 200,
                    width: double.infinity, 
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20,),
                Text(blog.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5
                ),
          
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}