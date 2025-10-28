import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecase/currentuser_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final CurrentuserUsecase _currentuserUsecase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required SignInUsecase signInUsecase,
    required CurrentuserUsecase currentuserUsecase,
    required AppUserCubit appUserCubit
  }) : _signUpUsecase = signUpUsecase,
       _signInUsecase = signInUsecase,
       _currentuserUsecase = currentuserUsecase,
       _appUserCubit = appUserCubit,

       super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>emit(AuthLoading()));  //now we don't need to emit loading in other events call , because of this line everytime events called than loading will be emitted    
    on<SignUpAuthEvent>(_signUpAuthEvent);
    on<SignInAuthEvent>(_signInAuthEvent);
    on<CurrentLoggedInUserEvent>(_currentLoggedInUserEvent);
  }

  void _signUpAuthEvent(SignUpAuthEvent event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final res = await _signUpUsecase.call(
      SignUpUsecaseParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _signInAuthEvent(SignInAuthEvent event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final res = await _signInUsecase.call(
      SignInUsecaseParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) =>_emitAuthSuccess(user,emit),
    );
  }

  void _currentLoggedInUserEvent(CurrentLoggedInUserEvent event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final res = await _currentuserUsecase.call(NoParams());

    res.fold(
      (failure)=>emit(AuthError(failure.message)), 
      (user)=>_emitAuthSuccess(user,emit)
        
      );


  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));


  }
}
