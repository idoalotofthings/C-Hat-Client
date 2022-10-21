import 'package:c_hat/network/websocket_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRepository {
  final ChatWebSocketClient client;
  late WebSocketChannel channel = client.channel;

  ChatRepository(this.client);
}
