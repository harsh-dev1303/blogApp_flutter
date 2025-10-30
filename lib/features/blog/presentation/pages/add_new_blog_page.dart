import 'dart:io';

import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  static route() => MaterialPageRoute(builder: (context)=>BlogPage()); 

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final List<String> topicsSelected = [];
  final formKey = GlobalKey<FormState>();
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new blog"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  image != null &&
                  topicsSelected.isNotEmpty) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user
                        .id;
                print("posterId in add new blog page: $posterId");
                context.read<BlogBloc>().add(
                  BlogUploadEvent(
                    image: image!,
                    topics: topicsSelected,
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    posterId: posterId,
                  ),
                );
              }
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogErrorState){
             snackBarMessage(context, state.mssg);
          }else if(state is BlogSuccessState){
             Navigator.pushAndRemoveUntil(
              context, 
              AddNewBlogPage.route(), 
              (route)=>false
              );
          }
        },
        builder: (context, state) {
          if(state is BlogLoadingState){
             return Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: AppPallete.borderColor,
                              radius: Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              dashPattern: [10, 5],
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open, size: 40),
                                    SizedBox(height: 15),
                                    Text(
                                      'Select Your Image',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  'Technology',
                                  'Bussiness',
                                  'Programming',
                                  'Entertainment',
                                ]
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsetsGeometry.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (topicsSelected.contains(e)) {
                                          topicsSelected.remove(e);
                                        } else {
                                          topicsSelected.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        color: topicsSelected.contains(e)
                                            ? WidgetStatePropertyAll(
                                                AppPallete.gradient1,
                                              )
                                            : null,
                                        label: Text(e),
                                        side: BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    BlogEditor(
                      textController: titleController,
                      hintText: 'Blog title',
                    ),
                    SizedBox(height: 8),
                    BlogEditor(
                      textController: contentController,
                      hintText: 'Blog content',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
