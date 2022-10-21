import 'package:platform_ui/platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/ui/mobile/chat/chat_widget.dart';
import 'package:c_hat/ui/mobile/user/user_widget.dart';
import 'package:c_hat/viewmodel/chat_viewmodel.dart';

class UserListElement extends StatefulWidget {
  
  final Platform platform;
  final ChatViewModel viewModel = ChatViewModel.getInstance()!;

  UserListElement(this.platform, {Key? key}) : super(key: key);

  @override
  State<UserListElement> createState() => _UserListElementState();
}

class _UserListElementState extends State<UserListElement> {


  @override
  Widget build(BuildContext context) {
    print(widget.viewModel.recipient.value!.username);
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => UserView(widget.platform, user: widget.viewModel.recipient.value!))));
      },

      onTap: () {
        //widget.viewModel.recipient.value = widget.user;      
        Navigator.push(context, MaterialPageRoute(builder: ((context) => ChatWidget(widget.platform))));
      },

      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/images/user_avatar.png",
                    height: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.viewModel.recipient.value!.username, style: const TextStyle(fontSize: 16),),
                ),
          
              ],
            ),
          ],
        ),
      ),
    );
  }
}
