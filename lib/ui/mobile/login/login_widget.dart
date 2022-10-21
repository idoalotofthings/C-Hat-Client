import 'package:c_hat/ui/mobile/login/register_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:c_hat/model/user.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:c_hat/ui/mobile/user_list/user_list_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';
import 'package:c_hat/viewmodel/chat_viewmodel.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute(this.platform, {Key? key}) : super(key: key);

  final Platform platform;
  final _usernameTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _serverIpTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChatViewModel viewModel;

    void connect() {
      String clientId = "";

      if (ChatViewModel.getInstance() == null) {
        viewModel = ChatViewModel.init(
            _serverIpTextFieldController.text,
            User(_usernameTextFieldController.text, clientId,
                password: _passwordTextFieldController.text));
      } else {
        viewModel = ChatViewModel.getInstance()!;
      }
      viewModel.login(viewModel.user.value);
    }

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
              child: PlatformTextField(platform,
                  controller: _usernameTextFieldController,
                  width: 256,
                  hint: "Username"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(platform,
                  controller: _passwordTextFieldController,
                  width: 256,
                  hint: "Password"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PlatformFilledButton(
                  platform,  
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => RegisterRoute(platform))));
                  },
                  child: const Text("Register"),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformFilledButton(platform, onPressed: () {
                    connect();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => UserListRoute(platform))));
                  }, child: const Text("Login")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlatformButton(platform, onPressed: () {
                    SystemNavigator.pop();
                  }, child: const Text("Exit")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
