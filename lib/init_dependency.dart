
import 'package:blog_app/core/common/cubit/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secreats.dart';
import 'package:blog_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository_data/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecase/currentuser_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_source/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repository_data/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_all_blog_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async{
  
  _initAuth();
  _initBlog();
  final supabaseIns= await Supabase.initialize(
    url:AppSecreats.supabaseUrl,
    anonKey: AppSecreats.supabaseAnonKey
  );

  Hive.defaultDirectory=(await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(()=>supabaseIns.client);  //"registerLazySingleton" make sure that whenever we need supabaseIns than only single instance is created overall app lifecycle.
  serviceLocator.registerLazySingleton(()=>AppUserCubit());
  serviceLocator.registerFactory(()=>InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(()=>ConnectionCheckerImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(()=>Hive.box(name: "blogs"));

}

void _initAuth(){
  serviceLocator
  ..registerFactory<AuthRemoteDataSource>(
    ()=>AuthRemoteDataSourceImpl(serviceLocator())
  )
  
  ..registerFactory<AuthRepository>(
    ()=>AuthRepoImpl(authRemoteDataSource: serviceLocator(), connectionChecker: serviceLocator())
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



void _initBlog(){
  serviceLocator
  ..registerFactory<BlogRemoteDataSource>(
    ()=>BlogRemoteDataSourceImp(serviceLocator())
  )

  ..registerFactory<BlogLocalDataSource>(
    ()=>BlogLocalDataSourceImpl(serviceLocator())
  )

  ..registerFactory<BlogRepository>(
    ()=>BlogRepositoryImpl(
      blogRemoteDataSource: serviceLocator(), 
      connectionChecker: serviceLocator(), 
      blogLocalDataSource: serviceLocator()
      )
  )
  ..registerFactory(
    ()=>UploadBlogUsecase(serviceLocator())
  )

  ..registerFactory(
    ()=>FetchAllBlogUsecase(serviceLocator())
    )

  ..registerLazySingleton(
    ()=>BlogBloc(
      uploadBlogUsecase: serviceLocator(),
      fetchAllBlogUsecase: serviceLocator()
      )
  );
    
}