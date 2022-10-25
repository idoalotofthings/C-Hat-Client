import 'package:c_hat/model/message.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class MessageReceivedState extends ChatState {
  final List<Message> messageList;
  @override
  List get props => [messageList];

  MessageReceivedState(this.messageList);
}

class MessageIdleState extends ChatState {
  @override
  List get props => [];
}
