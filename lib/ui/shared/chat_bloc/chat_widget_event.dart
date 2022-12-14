import 'package:c_hat/model/message.dart';
import 'package:c_hat/model/user.dart';

abstract class ChatWidgetEvent {
  final Message? message;
  ChatWidgetEvent({this.message});
}

class MessageReceivedEvent extends ChatWidgetEvent {
  MessageReceivedEvent({super.message});
}

class MessageSentEvent extends ChatWidgetEvent {
  MessageSentEvent({super.message});
}

class ListenToStreamEvent extends ChatWidgetEvent {
  final User user;

  ListenToStreamEvent({required this.user});
}
