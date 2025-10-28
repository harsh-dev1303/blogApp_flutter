import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {

  Session? get currentSession;   //this will give current loggin users email, id

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> currentUserData(); //this method will give current loggin user's data from db
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  
  /*In Dart a getter is invoked whenever you access it — you don't need to "call" it like a method. So every time your code uses currentSession (e.g. if (currentSession != null) or currentSession!.user.id) it executes the getter and returns */
  @override
  Session? get currentSession => supabaseClient.auth.currentSession;  //this will give current loggin users email, id

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try{
      final res=await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email
        );

      if(res.user==null){
          throw ServerException("user is null");
      }

       print("Signed in user: ${res.user!.toJson()}");
      return UserModel.fromJson(res.user!.toJson());
     

    }catch(e){
      throw ServerException(e.toString());
    }
   
    
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name':name
        }
      );
      if(response.user==null){
      
         throw ServerException("User is null");
      }
     print("Signed up user: ${response.user!.toJson()}");
      return UserModel.fromJson(response.user!.toJson()) ;
    } catch (e) {
    
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<UserModel?> currentUserData() async {
    
    try{
      if(currentSession != null){
      final currentUser = await supabaseClient.from('profiles').select().eq(   //here "from" refers to "table" or "which table" then "select" refers to column and when no specified any column then it will refer to all columns 
        'id', 
        currentSession!.user.id
        );

        return UserModel.fromJson(currentUser.first).copyWith(email:currentSession!.user.email);
      }

      return null;

    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
  
}
