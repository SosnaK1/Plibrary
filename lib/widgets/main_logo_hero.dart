import 'package:flutter/material.dart';

class MainLogoHero extends StatelessWidget {
  final double size;

  const MainLogoHero({Key key, this.size=120.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "main-logo",
        child: FlutterLogo(style: FlutterLogoStyle.stacked, size: size));
  }
}
