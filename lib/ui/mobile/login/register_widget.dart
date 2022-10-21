import 'package:c_hat/ui/mobile/login/verify_widget.dart';
import 'package:c_hat/ui/shared/heading_text.dart';
import 'package:c_hat/viewmodel/register_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';


class RegisterRoute extends StatefulWidget {

  final Platform platform;
  late RegisterViewModel viewModel;

  RegisterRoute(this.platform, {Key? key}) : super(key: key);

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final TextEditingController _usernameTextFieldController = TextEditingController();

  final TextEditingController _passwordTextFieldController = TextEditingController();

  final TextEditingController _mailTextFieldController = TextEditingController();

  final TextEditingController _serverIpTextFieldController = TextEditingController();

  String _confirmationText = "";

  void connect() {
    widget.viewModel = RegisterViewModel.getInstance()?? RegisterViewModel.init(_usernameTextFieldController.text, _passwordTextFieldController.text, 
        _mailTextFieldController.text, _serverIpTextFieldController.text
      );
  }

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      widget.platform, 
      appBar: AppBar(
        title: const Text("Welcome!"),
      ), 
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Welcome!"),
      ), 
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 128),

            const HeadingText("Register"),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                widget.platform, 
                hint: "Server IP", 
                controller: _serverIpTextFieldController
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                widget.platform, 
                hint: "Username", 
                controller: _usernameTextFieldController
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                widget.platform, 
                hint: "Password", 
                controller: _passwordTextFieldController
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                widget.platform, 
                hint: "Email", 
                controller: _mailTextFieldController
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformFilledButton(widget.platform, onPressed: () {
                    connect();

                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) {
                      return VerifyWidget(widget.platform);
                    }));
                  
                  }, child: const Text("Register")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlatformButton(widget.platform, onPressed: () {
                    //SystemNavigator.pop();
                    
                  }, child: const Text("Back")),
                )
              ],
            ),

            Text(_confirmationText, style: const TextStyle(color: Colors.green, fontSize: 12))

          ],
        ),
      )
    );
  }
}