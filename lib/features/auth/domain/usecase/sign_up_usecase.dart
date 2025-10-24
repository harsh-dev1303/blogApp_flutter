import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements UseCase<String, SignUpUsecaseParams> {
  AuthRepository authRepository;
  SignUpUsecase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(SignUpUsecaseParams params) async {
    final res=await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );

    return res;
  }
}

class SignUpUsecaseParams {
  final String name;
  final String email;
  final String password;

  SignUpUsecaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
