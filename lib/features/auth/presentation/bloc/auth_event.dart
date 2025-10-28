part of 'auth_bloc.dart';


sealed class AuthEvent {}

class SignUpAuthEvent extends AuthEvent{
  final String name;
  final String email;
  final String password;

  SignUpAuthEvent({
    required this.name,
    required this.email,
    required this.password
  });
}

class SignInAuthEvent extends AuthEvent{
  final String email;
  final String password;

  SignInAuthEvent({
    required this.email,
    required this.password
  });

}

class CurrentLoggedInUserEvent extends AuthEvent {}
