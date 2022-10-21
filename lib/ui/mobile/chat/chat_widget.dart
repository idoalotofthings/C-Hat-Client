import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/recipient_cubit/recipient_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/chat/chat_message_widget.dart';

class ChatWidget extends StatefulWidget {
  final Platform platform;
  final controller = TextEditingController();

  ChatWidget(this.platform, {Key? key}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: Text(BlocProvider.of<ChatWidgetBloc>(context).user.username),
        ),
        cupertinoBar: CupertinoNavigationBar(
          middle: Text(BlocProvider.of<ChatWidgetBloc>(context).user.username),
        ),
        body: BlocProvider<ChatWidgetBloc>.value(
            value: context.read<ChatWidgetBloc>(),
            child: BlocBuilder<ChatWidgetBloc, List<Message>>(
                builder: ((context, state) {
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
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          return ChatMessageWidget(
                            message: state[index],
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
                                  "Enter your message for ${context.read<ChatWidgetBloc>().user.username}",
                              controller: widget.controller),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PlatformFilledButton(
                          widget.platform,
                          onPressed: () {
                            context
                                .read<ChatWidgetBloc>()
                                .add(MessageSentEvent(
                                  message: Message(
                                    widget.controller.text,
                                    context.read<ChatWidgetBloc>().user.username,
                                    TimeOfDay.fromDateTime(DateTime.now()).toString(),
                                    BlocProvider.of<RecipientCubit>(context).state!.clientId
                                  )
                                ));
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
