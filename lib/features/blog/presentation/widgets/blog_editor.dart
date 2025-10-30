import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.textController,
    required this.hintText
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hint: Text(hintText)
      ),
      maxLines: null,
      validator: (value){
        if(value!.trim().isEmpty){
          return '$hintText cannot be empty';
        }
        else{
          return null;
        }
      },
    );
  }
}