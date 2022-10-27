import 'package:c_hat/network/websocket_client.dart';
import 'package:c_hat/ui/mobile/login/register_widget.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_bloc.dart';
import 'package:c_hat/ui/shared/chat_bloc/chat_widget_state.dart';
import 'package:c_hat/ui/shared/chat_repository/chat_repository.dart';
import 'package:c_hat/ui/shared/login_bloc/login_bloc.dart';
import 'package:c_hat/ui/shared/login_bloc/login_event.dart';
import 'package:c_hat/ui/shared/login_bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:c_hat/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute(this.platform, {Key? key}) : super(key: key);

  final Platform platform;
  final _mailIdTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _serverIpTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platform,
      appBar: AppBar(title: const Text("Welcome!")),
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Welcome"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 128),
            const HeadingText("Login"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(platform,
                  controller: _serverIpTextFieldController,
                  width: 256,
                  hint: "Server IP"),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                platform,
                controller: _mailIdTextFieldController,
                width: 256,
                hint: "Mail ID",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                platform,
                controller: _passwordTextFieldController,
                width: 256,
                hint: "Password",
                isPassword: true,
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PlatformFilledButton(
                        platform,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      RegisterRoute(platform))));
                        },
                        child: const Text("Register"),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformFilledButton(platform, onPressed: () {
                        var user = User(mailId: _mailIdTextFieldController.text,
                            password: _passwordTextFieldController.text);

                        final repository = ChatRepository(ChatWebSocketClient(
                            _serverIpTextFieldController.text));
                        final chatBloc = ChatWidgetBloc(repository,
                            value: MessageIdleState());

                        showDialog(
                            context: context,
                            builder: (context) {
                              return RepositoryProvider(
                                create: (context) => repository,
                                child: BlocProvider<LoginBloc>(
                                  create: (context) =>
                                      LoginBloc(context.read<ChatRepository>())
                                        ..add(TryLoginEvent(user)),
                                  child: BlocConsumer<LoginBloc, LoginState>(
                                      listener: (context, state) {
                                    if (state is LoginSuccess) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserListRoute(
                                                      platform, chatBloc,
                                                      loggedInUser: User(
                                                        mailId: user.mailId,
                                                        username:
                                                            state.username,
                                                        clientId:
                                                            state.clientId,
                                                      ))));
                                    }
                                  }, builder: (context, state) {
                                    if (state is LoginFailed) {
                                      return AlertDialog(
                                          content: SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: Text(
                                            (state.message),
                                          ),
                                        ),
                                      ));
                                    } else {
                                      return const SizedBox(
                                        child: AlertDialog(
                                            content: SizedBox(
                                                height: 100,
                                                width: 10,
                                                child:
                                                    CircularProgressIndicator())),
                                      );
                                    }
                                  }),
                                ),
                              );
                            });
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => RepositoryProvider(
                                      create: (context) => ChatRepository(
                                          ChatWebSocketClient(
                                              _serverIpTextFieldController.text)),
                                      child: BlocProvider<LoginBloc>(
                                        create: (context) => LoginBloc(
                                            context.read<ChatRepository>())
                                          ..add(TryLoginEvent(user)),
                                        child: BlocListener<LoginBloc, String>(
                                          listener: (context, state) {
                                            if (state is LoginSuccessEvent) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Center(
                                                      child: Text(
                                                        "Logged in with Client ID: $state",
                                                        style: const TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if(state is LoginFailedEvent) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Center(
                                                      child: Text(
                                                        state,
                                                        style: const TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: UserListRoute(
                                            platform,
                                            url: _serverIpTextFieldController.text,
                                            loggedInUser: user,
                                          ),
                                        ),
                                      ),
                                    ))));*/
                      }, child: const Text("Login")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: PlatformButton(platform, onPressed: () {
                        SystemNavigator.pop();
                      }, child: const Text("Exit")),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
