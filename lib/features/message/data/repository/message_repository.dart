import 'package:chat_app/core/shared_preferences/shared_preferences.dart';
import 'package:chat_app/features/message/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepository {
  MessageModel? messageModel;

  Future sendMessageRepositoryFunction({
    required String message,
    required dynamic date,
    required String receiver,
    required String sender,
  }) async {
    messageModel = MessageModel(
      message: message,
      date: date,
      receiver:  SharedPrefs.getData(key: "UID")==sender?receiver:sender,
      sender: SharedPrefs.getData(key: "UID"),
    );
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(sender)
        .collection("Messages")
        .doc(receiver).collection("Chats")
        .add(messageModel!.toMap());
  }

  Stream getAllMessagesRepositoryFunction({
    required String receiver,
    required String sender,
  })  {
    return  FirebaseFirestore.instance
        .collection("Users")
        .doc(sender)
        .collection("Messages")
        .doc(receiver).collection("Chats").orderBy("date")
        .snapshots();
  }
}