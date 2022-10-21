import 'dart:convert';

import 'package:c_hat/const/result.dart';
import 'package:c_hat/model/message.dart';
import 'package:c_hat/viewmodel/chat_viewmodel.dart';
import 'package:c_hat/viewmodel/register_viewmodel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:c_hat/model/user.dart';

abstract class WebSocketClient {
  final String wsUrl;
  const WebSocketClient(this.wsUrl);
}

class RegisterWebSocketClient extends WebSocketClient {
  late WebSocketChannel channel;
  RegisterViewModel viewModel = RegisterViewModel.getInstance()!;

  RegisterWebSocketClient(super.wsUrl);

  void registerUser(String username, String password, String mailId) {
    viewModel.result.value = Result.wait;

    try {
      channel =
          WebSocketChannel.connect(Uri.parse("wss://${super.wsUrl}/register"));
    } on Exception {
      viewModel.result.value = Result.error;
    }

    channel.sink.add(jsonEncode({
      "event": "register",
      "username": username,
      "password": password,
      "mail_id": mailId
    }));

    listen();
  }

  void listen() {
    Map jsonData = {};

    channel.stream.listen((event) {
      jsonData = jsonDecode(event);
      if (jsonData["event"] == "confirmation") {
        if (jsonData["status"] == "done") {
          viewModel.result.value = Result.success;
        } else {
          viewModel.result.value = Result.error;
        }
      }
    });

    //return subscription;
  }

  void verifyUser(int code) {
    channel.sink.add(jsonEncode({"event": "confirmation", "code": "$code"}));
  }
}

class ChatWebSocketClient extends WebSocketClient {
  late WebSocketChannel _channel;
  ChatViewModel viewModel = ChatViewModel.getInstance()!;

  ChatWebSocketClient(super.wsUrl) {
    _channel = WebSocketChannel.connect(Uri.parse("wss://${super.wsUrl}/chat"));
  }

  Future<Result> login(User user) async {
    _channel.sink.add(user.toJson());
    return Result.success;
  }

  void sendMessage(Message message) {
    _channel.sink.add(message.toJson());
  }

  WebSocketChannel get channel => _channel;
}
