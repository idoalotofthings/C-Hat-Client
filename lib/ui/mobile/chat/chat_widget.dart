import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_state.dart';
import 'package:c_hat/ui/shared/recipient_cubit/recipient_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/chat/chat_message_widget.dart';

class ChatWidget extends StatefulWidget {
  final Platform platform;
  final ChatWidgetBloc bloc;
  final RecipientCubit cubit;
  final controller = TextEditingController();

  ChatWidget(this.platform, this.bloc, this.cubit, {Key? key})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: Text(widget.bloc.user.username!),
        ),
        cupertinoBar: CupertinoNavigationBar(
          middle: Text(widget.bloc.user.username!),
        ),
        body: BlocProvider<ChatWidgetBloc>.value(
            value: widget.bloc,
            child: BlocBuilder<ChatWidgetBloc, ChatState>(
                builder: ((context, state) {
              print("object");
              var messages = [];

              if (state is MessageReceivedState) {
                messages = state.messageList;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return ChatMessageWidget(
                            message: messages.reversed.toList()[index],
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: PlatformTextField(widget.platform,
                              hint:
                                  "Enter your message for ${widget.bloc.user.username}",
                              controller: widget.controller),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PlatformFilledButton(
                          widget.platform,
                          onPressed: () {
                            var message = Message(
                                widget.controller.text,
                                widget.bloc.user.username!,
                                TimeOfDay.fromDateTime(DateTime.now())
                                    .toString()
                                    .replaceAll("TimeOfDay(", "")
                                    .replaceAll(")", ""),
                                widget.cubit.state!.clientId!);
                            
                            widget.bloc.add(MessageSentEvent(message: message));
                            widget.controller.text = "";
                          },
                          child: const Icon(Icons.send),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }))));
  }
}
