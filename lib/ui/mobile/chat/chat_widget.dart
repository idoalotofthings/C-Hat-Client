import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/model/message.dart';
import 'package:c_hat/platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/chat/chat_message_widget.dart';
import 'package:c_hat/viewmodel/chat_viewmodel.dart';

class ChatWidget extends StatefulWidget {
  final Platform platform;
  final controller = TextEditingController();
  final ChatViewModel viewModel = ChatViewModel.getInstance()!;

  ChatWidget(this.platform, {Key? key}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  void sendMessage(Message message) {
    widget.viewModel.sendMessage(message);
  }

  List? _messageList;

  @override
  Widget build(BuildContext context) {
    print(widget.viewModel.recipient.value!.username);
    if(widget.viewModel.message.value == null){
      _messageList = [];
    } else {
      _messageList = widget.viewModel.message.value!.reversed.toList();
    }

    widget.viewModel.message.observe(() {
      setState(() => _messageList = widget.viewModel.message.value);
    });

    return PlatformScaffold(widget.platform,
        appBar: AppBar(
          title: Text(widget.viewModel.recipient.value!.username),
        ),
        cupertinoBar: CupertinoNavigationBar(
          middle: Text(widget.viewModel.recipient.value!.username),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _messageList!.length,
                  itemBuilder: (context, index) {
                    return ChatMessageWidget(
                      message: _messageList![index],
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
                        hint: "Enter your message for ${widget.viewModel.recipient.value!.username}",
                        controller: widget.controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PlatformFilledButton(
                    widget.platform,
                    onPressed: () {
                      sendMessage(Message(
                          widget.controller.text,
                          widget.viewModel.user.value.username,
                          DateTime.now().toString(),
                          widget.viewModel.recipient.value!.clientId
                        ));

                        widget.controller.text = "";
                    },
                    child: const Icon(Icons.send),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
