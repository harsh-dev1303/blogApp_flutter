import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({required String email, required String password}) {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email, 
    required String password
    }) async {
      
      try{
        final res=await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name,
          email: email, 
          password: password);

          return Right(res);

      }on ServerException catch(e){
          return Left(Failure(e.message));
      }

  

  }

}