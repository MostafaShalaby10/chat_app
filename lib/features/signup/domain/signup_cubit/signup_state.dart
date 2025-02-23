part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class ChangePasswordVisibility extends SignupState {}
final class LoadingCreateUserAccountState extends SignupState {}
final class SuccessfullyCreateUserAccountState extends SignupState {}
final class ErrorCreateUserAccountState extends SignupState {
  final String error;
  ErrorCreateUserAccountState(this.error);
}


