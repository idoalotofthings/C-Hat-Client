import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class WebSocketClient {
  final String wsUrl;
  const WebSocketClient(this.wsUrl);
}

class RegisterWebSocketClient extends WebSocketClient {
  late WebSocketChannel channel;

  RegisterWebSocketClient(super.wsUrl) {
    channel =
        WebSocketChannel.connect(Uri.parse("ws://${super.wsUrl}/register"));
  }
}

class ChatWebSocketClient extends WebSocketClient {
  late WebSocketChannel _channel;
  late Stream stream;

  ChatWebSocketClient(super.wsUrl) {
    _channel = WebSocketChannel.connect(Uri.parse("ws://${super.wsUrl}/chat"));
    stream = _channel.stream.asBroadcastStream();
  }

  WebSocketChannel get channel => _channel;
}
