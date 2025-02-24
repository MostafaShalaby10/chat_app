part of 'update_data_cubit.dart';

@immutable
sealed class UpdateDataState {}

final class UpdateDataInitial extends UpdateDataState {}
final class LoadingUpdateNameAndPhoneState extends UpdateDataState {}

final class SuccessfullyUpdateNameAndPhoneState extends UpdateDataState {}

final class ErrorUpdateNameAndPhoneState extends UpdateDataState {
  final String error;

  ErrorUpdateNameAndPhoneState(this.error);
}