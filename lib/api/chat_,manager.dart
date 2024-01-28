import 'package:cloud_firestore/cloud_firestore.dart';

import 'dashbot.dart';

Dashbot dash = Dashbot();

class ChatManager {
  final List<Message> messages = [];

  Stream<DocumentSnapshot>? userDataSnapshot;

  void newMessage(Message message) {
    messages.add(message);
  }

  void getResponse(Message message) {
    messages.add(dash.getResponseMessage(message));
  }

  void clearMessages() {
    messages.clear();
  }
}

class Message {
  String sender;
  String message;

  Message({
    required this.sender,
    required this.message,
  });
}
