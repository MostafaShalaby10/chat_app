part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}




final class LoadingGetSpecificUserDataState extends SettingsState {}

final class SuccessfullyGetSpecificUserDataState extends SettingsState {}

final class ErrorGetSpecificUserDataState extends SettingsState {
  final String error;

  ErrorGetSpecificUserDataState(this.error);
}
final class LoadingDeleteAccountState extends SettingsState {}

final class SuccessfullyDeleteAccountState extends SettingsState {}

final class ErrorDeleteAccountState extends SettingsState {
  final String error;

  ErrorDeleteAccountState(this.error);
}

final class SuccessfullyLogOutState extends SettingsState {}
