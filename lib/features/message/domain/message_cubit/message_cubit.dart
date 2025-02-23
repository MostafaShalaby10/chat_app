import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/message_model.dart';
import '../../data/repository/message_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  static MessageCubit get(context) => BlocProvider.of(context);

  MessageModel? messageModel;
  MessageRepository messageRepository = MessageRepository();

  Future sendMessageCubitFunction({
    required String message,
    required dynamic date,
    required String receiver,
    required String sender,
  }) async {
    emit(LoadingSendingMessageState());
    // Save message for sender
    await messageRepository
        .sendMessageRepositoryFunction(
          message: message,
          date: date,
          receiver: receiver,
          sender: sender,
        )
        .then((value) async {
          // Save message for receiver

          messageRepository
              .sendMessageRepositoryFunction(
                message: message,
                date: date,
                receiver: sender,
                sender: receiver,
              )
              .then((value) {
                emit(SuccessfullySendingMessageState());
              })
              .catchError((error) {
                emit(ErrorSendingMessageState(error.toString()));
              });
        })
        .catchError((error) {
          emit(ErrorSendingMessageState(error.toString()));
        });
  }

  List messages = [];

  Stream getAllMessagesCubitFunction({
    required String receiver,
    required String sender,
  }) async* {
    messages.clear();
    emit(LoadingReceivingMessageState());
    await messageRepository
        .getAllMessagesRepositoryFunction(receiver: receiver, sender: sender)
        .listen((value) {
          value.docs.forEach((element) {
            messageModel = MessageModel.fromJson(element.data());
            messages.add(messageModel!.toMap());
            print("Message in for ---$messages") ;

          });
          print("Message out for ---$messages") ;
          emit(SuccessfullyReceivingMessageState());
        })
        .asFuture((error) {
          emit(ErrorReceivingMessageState(error.toString()));
        });
  }
}
