import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;

  dynamic  date ;
  String? receiver;

  String? sender;

  MessageModel({
    required this.message,
    required this.date,
    required this.receiver,
    required this.sender,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    receiver = json['receiver'];
    sender = json['sender'];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "date": date,
      "receiver": receiver,
      "sender": sender,
    };
  }
}