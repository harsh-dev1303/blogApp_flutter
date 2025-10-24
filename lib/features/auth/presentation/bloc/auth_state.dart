part of 'auth_bloc.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState{
  final String uid;
  AuthSuccess(this.uid);
}
final class AuthError extends AuthState{
  final String errorMessage;
  AuthError(this.errorMessage);
}
