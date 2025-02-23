part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}
final class LoadingSendingMessageState extends MessageState {}
final class SuccessfullySendingMessageState extends MessageState {}
final class ErrorSendingMessageState extends MessageState {
  final String error;
  ErrorSendingMessageState(this.error);
}

final class LoadingReceivingMessageState extends MessageState {}
final class SuccessfullyReceivingMessageState extends MessageState {}
final class ErrorReceivingMessageState extends MessageState {
  final String error;
  ErrorReceivingMessageState(this.error);
}
