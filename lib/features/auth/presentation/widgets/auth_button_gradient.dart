import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButtonGradient extends StatelessWidget {
  final String btnText;
  const AuthButtonGradient({
    super.key,
    required this.btnText
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
          ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(      //this widget don't gives an option for gradient color hence we use or this with "Container"
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          fixedSize: Size(385,55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
         child: Text(btnText,style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600
        ),)
        ),
    );
  }
}
