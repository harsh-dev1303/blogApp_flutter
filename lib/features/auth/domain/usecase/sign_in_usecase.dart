import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignInUsecase implements UseCase<User,SignInUsecaseParams >{
  
  AuthRepository authRepository;
  SignInUsecase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignInUsecaseParams params) async {
   
   final res = await authRepository.signInWithEmailAndPassword(
    email: params.email, 
    password: params.password
    );

    return res;
    
  }

}

class SignInUsecaseParams {
   final String email;
   final String password;

   SignInUsecaseParams({
    required this.email,
    required this.password
   });
}