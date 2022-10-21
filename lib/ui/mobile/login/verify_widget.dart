import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class VerifyWidget extends StatelessWidget {

  final Platform platform;
  final TextEditingController _verificationCodeController = TextEditingController();

  VerifyWidget(this.platform, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      platform, 
      appBar: AppBar(
        title: const Text("Verify your email"),
      ), 

      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Verify your email"),
      ), 

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlatformTextField(
                platform,
                hint: "Enter your verification code",
                controller: _verificationCodeController,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformButton(
                    platform, 
                    onPressed: () {},
                    child: const Text("Back"), 
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformFilledButton(
                    platform, 
                    onPressed: () {
                      
                    },
                    child: const Text("Verify"), 
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}