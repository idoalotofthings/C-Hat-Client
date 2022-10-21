import 'package:c_hat/model/user.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_event.dart';
import 'package:c_hat/ui/shared/recipient_cubit/recipient_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/ui/mobile/chat/chat_widget.dart';
import 'package:c_hat/ui/mobile/user/user_widget.dart';

class UserListElement extends StatefulWidget {
  final User user;

  final Platform platform;
  final String url;

  const UserListElement(this.platform,
      {required this.user, required this.url, Key? key})
      : super(key: key);

  @override
  State<UserListElement> createState() => _UserListElementState();
}

class _UserListElementState extends State<UserListElement> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatWidgetBloc>(
      create: (context) => ChatWidgetBloc()
        ..add(ListenToStreamEvent(widget.url, user: widget.user)),
      child: BlocProvider<RecipientCubit>(
        create: (context) => RecipientCubit(),
        child: GestureDetector(
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => UserView(widget.platform,
                        user: BlocProvider.of<RecipientCubit>(context).value!))));
          },
          onTap: () {
            context.read<RecipientCubit>().value = widget.user;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ChatWidget(widget.platform))));
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
                      child: Text(
                        BlocProvider.of<RecipientCubit>(context).value!.username,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
