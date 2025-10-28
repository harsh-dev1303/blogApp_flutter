
import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secreats.dart';
import 'package:blog_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository_data/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/currentuser_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async{
  _initAuth();
  final supabaseIns= await Supabase.initialize(
    url:AppSecreats.supabaseUrl,
    anonKey: AppSecreats.supabaseAnonKey
  );
  serviceLocator.registerLazySingleton(()=>supabaseIns.client);  //"registerLazySingleton" make sure that whenever we need supabaseIns than only single instance is created overall app lifecycle.
  serviceLocator.registerLazySingleton(()=>AppUserCubit());

}

void _initAuth(){
  serviceLocator
  ..registerFactory<AuthRemoteDataSource>(
    ()=>AuthRemoteDataSourceImpl(serviceLocator())
  )
  ..registerFactory<AuthRepository>(
    ()=>AuthRepoImpl(serviceLocator())
  )
  ..registerFactory(
    ()=>SignUpUsecase(serviceLocator())
  )
  ..registerFactory(
    ()=>SignInUsecase(serviceLocator())
  )
  ..registerFactory(
    ()=>CurrentuserUsecase(serviceLocator())
    )
    ..registerLazySingleton(
    ()=>AuthBloc(
      signUpUsecase: serviceLocator(),
      signInUsecase: serviceLocator(),
      currentuserUsecase: serviceLocator(),
      appUserCubit: serviceLocator()
      )
  );

  
    
}