import 'package:chat_app/core/widgets/widgets.dart';
import 'package:chat_app/features/message/domain/message_cubit/message_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_preferences/shared_preferences.dart';

class MessageView extends StatelessWidget {
  final String receiver;
  final String name;

  const MessageView({super.key, required this.receiver , required this.name});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return BlocProvider(
      create:
          (context) =>
      MessageCubit()..getAllMessagesCubitFunction(
        receiver: receiver,
        sender: SharedPrefs.getData(key: "UID"),
      ),
      child: BlocConsumer<MessageCubit, MessageState>(
        listener: (context, state) {
          if (state is SuccessfullySendingMessageState) {
            messageController.clear();
          } else if (state is ErrorSendingMessageState) {
            print(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: defaultText(text: name, fontSize: 14),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              state is! LoadingReceivingMessageState
                  ? Column(
                children: [
                  Expanded(
                    child:
                    MessageCubit.get(context).messages.isNotEmpty
                        ? ListView.builder(
                      itemCount: MessageCubit.get(context).messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment:
                            MessageCubit.get(context).messages[index]['sender'] ==SharedPrefs.getData(key: "UID")
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                MessageCubit.get(context).messages[index]['sender'] ==SharedPrefs.getData(key: "UID")
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius:
                                BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  15.0,
                                ),
                                child: defaultText(
                                  textAlign: TextAlign.start,
                                  text: "${MessageCubit.get(context).messages[index]['message']}" ,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: defaultText(
                        text: "Send first message",
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: defaultTextFormField(
                          hintText: "Enter your message",
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          prefixIcon: null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: state is! LoadingSendingMessageState ?defaultButton(
                          text: "Send",
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              MessageCubit.get(
                                context,
                              ).sendMessageCubitFunction(
                                message: messageController.text,
                                date: DateTime.now() ,
                                receiver: receiver,
                                sender: SharedPrefs.getData(key: "UID"),
                              );
                            }
                          },
                          color: Colors.blue,
                        ):Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ],
              )
                  : Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}