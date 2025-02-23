part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class ChangePasswordVisibility extends LoginState {}

final class LoadingLoginState extends LoginState {}
final class SuccessfullyLoginState extends LoginState {}
final class ErrorLoginState extends LoginState {
  final String error;
  ErrorLoginState(this.error);
}
