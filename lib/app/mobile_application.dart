import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:c_hat/platform_ui/src/platform.dart';
import 'package:c_hat/theme/material/material_theme.dart';
import 'package:c_hat/ui/mobile/login/login_widget.dart';
import 'package:universal_io/io.dart' as io show Platform;

class MobileApplication extends StatelessWidget {
  const MobileApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (io.Platform.isAndroid) {
      return MaterialApp(
        theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
        darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
        themeMode: ThemeMode.light,
        home: LoginRoute(Platform.android),
      );
    } else if (io.Platform.isIOS) {
      return CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: lightColorScheme.primary,
        ),
        home: LoginRoute(Platform.ios),
      );
    } else {
      throw Exception("Undefined Platform");
    }
  }
}
