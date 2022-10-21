import 'package:c_hat/model/message.dart';
import 'package:c_hat/model/user.dart';
import 'package:c_hat/network/websocket_client.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/chat_repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWidgetBloc extends Bloc<ChatWidgetEvent, List<Message>> {
  List<Message> value;
  late User user;

  late ChatRepository repository;

  ChatWidgetBloc({this.value = const []}) : super(value) {
    on<ListenToStreamEvent>((event, emit) {
      repository = ChatRepository(ChatWebSocketClient(event.url));
      repository.channel.stream.listen((event) {
        add(MessageReceivedEvent(message: Message.fromJson(event)));
      });
    });

    on<MessageReceivedEvent>((event, emit) {
      value.add(event.message!);
      emit(value);
    });

    on<MessageSentEvent>((event, emit) {
      repository.channel.sink.add(event.message?.toJson());
    });
  }
}
