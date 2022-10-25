import 'package:c_hat/model/user.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_element.dart';

class UserListRoute extends StatefulWidget {
  final User loggedInUser;
  final ChatWidgetBloc bloc;
  final Platform platform;

  const UserListRoute(this.platform, this.bloc,
      {required this.loggedInUser, Key? key})
      : super(key: key);

  @override
  State<UserListRoute> createState() => _UserListRouteState();
}

class _UserListRouteState extends State<UserListRoute> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      widget.platform,
      appBar: AppBar(
        title: const Text("Friends and Groups"),
      ),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Friends and Groups"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return UserListElement(
            widget.platform,
            widget.bloc,
            user: widget.loggedInUser,
          );
        },
      ),
      actionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          // TODO
        },
      ),
    );
  }
}
