part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}    //this is logout state

final class AppUserLoggedIn extends AppUserState{
  final User user;
  AppUserLoggedIn(this.user);
}
