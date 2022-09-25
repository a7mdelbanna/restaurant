abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginGetDataInitialState extends LoginStates {}

class LoginGetDataLoadingState extends LoginStates {}

class LoginGetDataSuccessState extends LoginStates {}

class LoginGetDataErrorState extends LoginStates {
  final String error;
  LoginGetDataErrorState(this.error);
}

class LoginChangeCheckBoxState extends LoginStates {}

class LoginChangePasswordVisibility extends LoginStates {}

class ForgetPasswordChecked extends LoginStates {
  final String password;
  ForgetPasswordChecked(this.password);
}

class ForgetPasswordInitial extends LoginStates {}

class UpdatePasswordInitial extends LoginStates {}

class ForgetPasswordCheckFailed extends LoginStates {}

class PasswordUpdated extends LoginStates {}

class UsersLoading extends LoginStates {}
// class UsersLoaded extends LoginStates{
//   List<UserModel>
//
// }
