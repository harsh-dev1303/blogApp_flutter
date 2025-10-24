import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
         Padding(
           padding: const EdgeInsets.all(15),
           child: Form(
            key: formKey,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Sign in",style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                const SizedBox(height: 30),
                AuthField(hintText: "Email",controller: emailController),
                const SizedBox(height: 15),
                AuthField(hintText: "password",controller: passwordController,isObsecure: true),
                SizedBox(height: 20),
                AuthButtonGradient(btnText: "sign in",),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style:Theme.of(context).textTheme.titleMedium  ,   //default styling of flutter we used here ,
                    children: [
                      TextSpan(
                        text:"Sign in",
                        style: Theme.of(context).textTheme.titleMedium ?.copyWith(   //this copy width is used to copy the previous style and add some more to it
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold
             
                        )
                      )
                    ]
                  )
                  )
             
             
              ],
                     ),
           ),
         ),
      
    );
  }
}