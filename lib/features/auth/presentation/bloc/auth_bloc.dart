
import 'package:blog_app/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignUpUsecase _signUpUsecase;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
  }) : _signUpUsecase = signUpUsecase
  ,super(AuthInitial()) {

    on<SignUpAuthEvent>((event, emit) async{
      final res = await _signUpUsecase.call(
        SignUpUsecaseParams(
        name: event.name, 
        email: event.email, 
        password: event.password
        )
        );

        res.fold(
          (failure)=>emit(AuthError(failure.message)), 
          (uid)=>emit(AuthSuccess(uid))
          );
    });
  }
}
