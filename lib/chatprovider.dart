import 'package:flutter/foundation.dart';

class Message {
  final String message;
  Message(this.message);
}

class ChatModel extends ChangeNotifier {
  final List<Message> mesages1 = [];
  get allmsg=>mesages1;
  void add(String message) {
    Message txtmsg = Message(message);
    print("message added");
    mesages1.add(txtmsg);
    notifyListeners();
  }

  void clear() {
    mesages1.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    print('ChatModel disposed');
    super.dispose();
  }
}
