part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthCompletedState extends AuthState {
  @override
  List<Object> get props => [];
}
class RegisterLoadedState extends AuthState {
  final UserModel user;
  const RegisterLoadedState(this.user);
  @override
  List<Object> get props => [user];
}

class LoginLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLoadedState extends AuthState {
  final UserModel user;
  const LoginLoadedState(this.user);
  @override
  List<Object> get props => [user];
}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState(this.error);
  @override
  List<Object> get props => [error];
}
class LoginPasswordVisibility extends AuthState {

   LoginPasswordVisibility();
  @override
  List<Object> get props => [];
}
class PasswordVisibilityState extends AuthState {

  PasswordVisibilityState();
  @override
  List<Object> get props => [];
}
class RegisterPasswordVisibility extends AuthState {

   RegisterPasswordVisibility();
  @override
  List<Object> get props => [];
}
class RegisterConfirmPasswordVisibility extends AuthState {

   RegisterConfirmPasswordVisibility();
  @override
  List<Object> get props => [];
}