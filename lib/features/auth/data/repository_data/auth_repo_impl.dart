import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email, 
    required String password
    }) async{
      try{
       final user=await authRemoteDataSource.signInWithEmailAndPassword(
        email: email, 
        password: password
        );
        
        return Right(user);

      }on ServerException catch(e){
        return Left(Failure(e.message));
      }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email, 
    required String password
    }) async {
      
      try{
        final user=await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name,
          email: email, 
          password: password);
         
          return Right(user);

      }on ServerException catch(e){
       
          return Left(Failure(e.message));
      }

  

  }
  
  @override
  Future<Either<Failure, User>> getCurrentUserData() async {
    try{
     final user = await authRemoteDataSource.currentUserData();
      if(user == null){
        return left(Failure("No logged in user found"));
      }
     return right(user);

    }on ServerException catch(e){
     return left(Failure(e.message));
    }
    
  }

}