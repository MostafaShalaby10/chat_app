part of 'update_cubit.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}
final class LoadingUpdatePasswordState extends UpdateState {}
final class SuccessfullyUpdatePasswordState extends UpdateState {}
final class ErrorUpdatePasswordState extends UpdateState {
  final String error;
  ErrorUpdatePasswordState(this.error);
}
final class ChangePasswordVisibilityState extends UpdateState {}
