part of 'data_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class LoadingGetAllUsersDataState extends HomeState {}
final class SuccessfullyGetAllUsersDataState extends HomeState {}
final class ErrorGetAllUsersDataState extends HomeState {
  final String error;
  ErrorGetAllUsersDataState(this.error);
}
