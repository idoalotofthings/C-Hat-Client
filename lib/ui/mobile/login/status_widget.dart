import 'package:c_hat/platform_ui/platform_ui.dart';
import 'package:c_hat/viewmodel/register_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c_hat/const/result.dart';


class StatusWidget extends StatelessWidget {

  final Platform platform;
  final RegisterViewModel viewModel = RegisterViewModel.getInstance()!;

  StatusWidget(this.platform, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    IconData icon;

    if(viewModel.result.value == Result.success){
      icon = Icons.done;
    } else {
      icon = Icons.close;
    }

    return PlatformScaffold(
      platform, 
      appBar: AppBar(
        title: const Text("Status"),
      ), 
      cupertinoBar: const CupertinoNavigationBar(
        middle: Text("Status"),
      ), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50,)
          ],
        ),
      )
    );
  }
}