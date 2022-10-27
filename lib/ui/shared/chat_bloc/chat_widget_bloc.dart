import 'package:c_hat/model/message.dart';
import 'package:c_hat/model/user.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_state.dart';
import 'package:c_hat/ui/shared/chat_repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWidgetBloc extends Bloc<ChatWidgetEvent, ChatState> {
  ChatState value;
  List<Message> messages = [];
  late User user;

  final ChatRepository repository;

  ChatWidgetBloc(this.repository, {required this.value}) : super(value) {
    on<ListenToStreamEvent>((event, emit) {
      repository.client.stream.listen((event) {
        add(MessageReceivedEvent(message: Message.fromJson(event)));
      });
    });

    on<MessageReceivedEvent>((event, emit) {
      messages.add(event.message!);
      emit(MessageReceivedState(List.from(messages)));
    });

    on<MessageSentEvent>((event, emit) {
      add(MessageReceivedEvent(message: event.message));
      repository.client.channel.sink.add(event.message?.toJson());
    });
  }
}
