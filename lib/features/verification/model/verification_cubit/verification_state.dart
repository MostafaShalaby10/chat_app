part of 'verification_cubit.dart';

@immutable
sealed class VerificationState {}

final class VerificationInitial extends VerificationState {}
final class LoadingCheckEmailValidationState extends VerificationState {}
final class SuccessfullyCheckEmailValidationState extends VerificationState {}
final class ErrorCheckEmailValidationState extends VerificationState {
  final String error;
  ErrorCheckEmailValidationState(this.error);
}

final class LoadingEmailValidationState extends VerificationState {}
final class SuccessfullyEmailValidationState extends VerificationState {}
final class ErrorEmailValidationState extends VerificationState {
  final String error;
  ErrorEmailValidationState(this.error);
}
final class TimeCounterState extends VerificationState {}
