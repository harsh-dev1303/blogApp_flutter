import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static newRoute()=>MaterialPageRoute(builder:(context)=>BlogPage() );
  static route()=>MaterialPageRoute(builder:(context)=>AddNewBlogPage() );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchEvent());
  }
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
      body: BlocConsumer<BlogBloc,BlogState>(
        listener: (context,state){
          if(state is BlogErrorState){
            snackBarMessage(context, state.mssg);
          }
        },
        builder: (context,state){
          if(state is BlogLoadingState){
            return const Loader();
          }
          if(state is BlogFetchedSuccessState){
            return ListView.builder(
              itemCount:state.blogList.length ,
              itemBuilder: (context,index){
                final blog=state.blogList[index];
                return BlogCard(
                  blog: blog, 
                  color: index % 3 ==0
                  ?AppPallete.gradient1
                  :index % 3 ==1
                   ?AppPallete.gradient2
                   :AppPallete.gradient3
                  );
                

              },
              
              );
          }

          return SizedBox();

        }, 
        
        ),
    );
  }
}


