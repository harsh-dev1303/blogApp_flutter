import 'package:blog_app/core/common/utils/snackbar.dart';
import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route()=>MaterialPageRoute(builder: (context)=>SigninPage());  
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
         Padding(
           padding: const EdgeInsets.all(15),
           child: BlocConsumer<AuthBloc,AuthState>(
            listener: (context,state){
              if(state is AuthError){
                snackBarMessage(context,state.errorMessage);
              }
            },
            builder: (context,state){
              if(state is AuthLoading){
                return Loader();
              }
             return Form(
              key: formKey,
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Sign up",style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: "Name",controller: nameController),
                  const SizedBox(height: 15),
                  AuthField(hintText: "Email",controller: emailController),
                  const SizedBox(height: 15),
                  AuthField(hintText: "password",controller: passwordController,isObsecure: true),
                  SizedBox(height: 20),
                  AuthButtonGradient(
                    btnText: "sign Up",
                    onPressed: ()=>{
                      if(formKey.currentState!.validate()){
                        context.read<AuthBloc>().add(
                          SignUpAuthEvent(
                            name: nameController.text.trim(), 
                            email: emailController.text.trim(), 
                            password: passwordController.text.trim()
                            )
                        )
             
                      }
             
                    },
                    ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                        Navigator.push(context,SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
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
                      ),
                  )
               
               
                ],
                       ),
             ); 
  }
           ),
         ),
      
    );
  }
}