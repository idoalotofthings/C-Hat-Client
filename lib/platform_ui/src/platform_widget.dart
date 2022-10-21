import 'package:flutter/material.dart';
import 'package:c_hat/platform_ui/src/platform.dart';

abstract class PlatformWidget extends StatelessWidget {

  final Platform platform;

  const PlatformWidget(this.platform, {Key? key}) : super(key: key);

}
