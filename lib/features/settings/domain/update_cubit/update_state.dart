part of 'update_cubit.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}
final class LoadingUpdateEmailState extends UpdateState {}

final class SuccessfullyUpdateEmailState extends UpdateState {}

final class ErrorUpdateEmailState extends UpdateState {
  final String error;

  ErrorUpdateEmailState(this.error);
}

final class LoadingUpdatePasswordState extends UpdateState {}

final class SuccessfullyUpdatePasswordState extends UpdateState {}

final class ErrorUpdatePasswordState extends UpdateState {
  final String error;
  ErrorUpdatePasswordState(this.error);
}
final class ChangePasswordVisibilityState extends UpdateState {}
