import 'package:flutter/material.dart' as material;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:c_hat/platform_ui/src/platform.dart';
import 'platform_widget.dart';

class PlatformScaffold extends PlatformWidget {

  final material.Widget body;
  final material.AppBar appBar;
  final cupertino.CupertinoNavigationBar cupertinoBar;
  final material.FloatingActionButton? actionButton;

  const PlatformScaffold(super.platform, {material.Key? key, this.actionButton, required this.appBar, required this.cupertinoBar, required this.body}) : super(key: key);

  @override
  material.Widget build(material.BuildContext context) {
    switch(platform) {

      case Platform.android:
      case Platform.web:
      case Platform.linux:
      case Platform.windows:
        return material.Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: actionButton,
        );

      case Platform.ios:
      case Platform.macos:
        return cupertino.CupertinoPageScaffold(
          navigationBar: cupertinoBar,
          child: body,
        );
    }
  }

}